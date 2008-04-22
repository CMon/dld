 /*
  * obUSBStrategy.cpp  - domestic location detection - gain data daemon USB OB device strategy
  *
  * Copyright (c) by Simon Schäfer <Simon.Schaefer@koeln.de>
  *
  * *************************************************************************
  * *                                                                       *
  * * This program is free software; you can redistribute it and/or modify  *
  * * it under the terms of the GNU General Public License as published by  *
  * * the Free Software Foundation; either version 2 of the License, or     *
  * * (at your option) any later version.                                   *
  * *                                                                       *
  * *************************************************************************
 */
/** @class OpenBeaconUSBStrategy obUSBStrategy.h
 *
 * @author Simon Schaefer
 *
 * @date 18.02.2008
 *
 * @version 1.0
 * <br> Class for the OpenBeacon USB device strategy
 */
#include "deviceStrategy.h"
#include "obUSBStrategy.h"
#include "../../common/obCommunication.h"
#include "../../common/dldLog.h"

#include <QSettings>
#include <QString>
#include <QMap>
#include <QTextStream>
#include <QStringList>
#include <QDir>
/**
 * @brief constructor of OpenBeaconUSBStrategy class
 * @param configName	base of configuration file
 * @param pLog		pointer to the parants log instance
 * @return
 * 	void
 */
OpenBeaconUSBStrategy::OpenBeaconUSBStrategy (QString configName, DLDLog * pLog)
{
	log = pLog;
	settings = new QSettings (configName, "obUSBStrategy");
	log->debugLog (QString("OpenBeacon USB Strategy Configuration is located in %1.").arg(settings->fileName ()));

	readConfiguration ();
}
/**
 * @brief destructor of OpenBeaconUSBStrategy class
 * @return
 * 	void
 */
OpenBeaconUSBStrategy::~OpenBeaconUSBStrategy ()
{
	disconnectDevices ();
	writeConfiguration ();

	devices.clear ();
	deviceInfos.clear ();

	if (settings)
		delete (settings);
}
/**
 * @brief reads the configuration and stores the information in the deviceInfos QMap
 * @return
 * 	void
 */
void OpenBeaconUSBStrategy::readConfiguration ()
{
	QStringList groups = settings->childGroups();
	maxPackages = settings->value ("maxPackagesOnOB", 10).toInt();
	for (int i = 0; i < groups.size(); ++i)
	{
		DeviceInformation * info = new DeviceInformation ();
		settings->beginGroup(groups.at(i));
		info->path = "";
		info->id = settings->value ("id", 0).toInt ();
		info->x = settings->value ("x", 0).toDouble ();
		info->y = settings->value ("y", 0).toDouble ();
		info->z = settings->value ("z", 0).toDouble ();
		deviceInfos.append (info);
		settings->endGroup ();
	}
}
/**
 * @brief writes the configuration of the devices
 * @return
 * 	void
 */
void OpenBeaconUSBStrategy::writeConfiguration ()
{
	settings->setValue("maxPackagesOnOB", maxPackages);
	for (int i = 0; i < deviceInfos.size(); ++i)
	{
		settings->beginGroup(QString ("OpenBeacon-%1").arg(i));
		settings->setValue("id", deviceInfos.at(i)->id);
		settings->setValue("x", deviceInfos.at(i)->x);
		settings->setValue("y", deviceInfos.at(i)->y);
		settings->setValue("z", deviceInfos.at(i)->z);
		settings->endGroup ();
	}
	settings->sync ();
}
/**
 * @brief connects ALL devices
 * @return
 * 	void
 */
void OpenBeaconUSBStrategy::connectDevices ()
{
	loadDevices ();
	QMapIterator<QString, OpenBeaconCommunication *> i(devices);
	while (i.hasNext())
	{
		i.next();
		if (i.value())
		{
			i.value ()->startCommunication ();
			i.value ()->sendToOB (QString ("FIFO %1").arg (maxPackages));
			i.value ()->sendToOB ("D");
			log->debugLog (QString("Started device %1").arg (i.key()));
		}
	}
}
/**
 * @brief connect one devices
 * @param path path of device
 * @return
 * 	void
 */
void OpenBeaconUSBStrategy::connectDevice (QString path)
{
	devices[path]->startCommunication ();
}
/**
 * @brief disconnects one devices
 * @param path path of device
 * @return
 * 	void
 */
void OpenBeaconUSBStrategy::disconnectDevice (QString path)
{
	devices[path]->stop ();
}
/**
 * @brief disconnects ALL devices
 * @return
 * 	void
 */
void OpenBeaconUSBStrategy::disconnectDevices ()
{
	QMapIterator<QString, OpenBeaconCommunication *> i(devices);
	while (i.hasNext())
	{
		i.next();
		if (i.value())
			i.value ()->stop ();
	}
}
/**
 * @brief adds a device
 * @param path path of the device
 * @return
 * 	void
 */
void OpenBeaconUSBStrategy::addDevice (QString path)
{
	OpenBeaconCommunication * device = new OpenBeaconCommunication (log);
	connect (device, SIGNAL(newData (QString)), this, SLOT(parseNewData (QString)));

	device->setDevicePath (path);

	log->infoLog (QString ("Device added: %1").arg(path));

	devices.insert (path, device);
}
/**
 * @brief removes the specific device
 * @param path path of the device
 * @return
 * 	void
 */
void OpenBeaconUSBStrategy::removeDevice (QString path)
{
	if (!devices.contains (path))
		return ;

	if (devices.value (path))
		delete (devices.value (path));
	devices.remove (path);
	log->infoLog (QString ("Device removed: %1.").arg(path));
}
/**
 * @brief prints an example of a configuration file
 * @return
 * 	void
 */
void OpenBeaconUSBStrategy::printSampleConfig ()
{
	QTextStream out (stdout);
	out << "The following gives an example of two configuration entries for the obStrategy configuration ";
	out << "and belongs into: " << settings->fileName () << endl << endl;
	out	<< "[#dev#test]" << endl
		<< "id=0" << endl
		<< "x=0" << endl
		<< "y=0" << endl
		<< "z=0";
}
/**
 * @brief retrieves the information of one device
 * @param path path of the device from which the info should be fetched
 * @return
 * 	DeviceInformation the information for the requested path beacon
 */
DeviceInformation * OpenBeaconUSBStrategy::getDeviceInformation (QString path)
{
	for (int i = 0; i < deviceInfos.size(); i++)
	{
		if (deviceInfos.at(i)->path == path)
			return (deviceInfos.at(i));
	}
	return (0);
}
/**
 * @brief loads the devices itself, info input comes from the settings, output will be a filled devices QMap
 * @return
 * 	void
 */
void OpenBeaconUSBStrategy::loadDevices ()
{
	QString obPath = settings->value("OpenBeaconBasepath", "ttyACM").toString ().append ("*");
	QStringList filter;
	filter << obPath;
	QDir dir("/dev/");
	QStringList deviceList = dir.entryList(filter, QDir::System);

	for (int i = 0; i < deviceList.size();i++)
	{
		QString device = deviceList.at(i);
		device.prepend ("/dev/");
		addDevice (device);
	}
}
/**
 * @brief sets the path for the matching ID
 * @param id	the id which path should be set
 * @param path	path to which it should be set
 * @return
 * 	void
 */
void OpenBeaconUSBStrategy::setPath (int id, QString path)
{
	for (int i = 0; i < deviceInfos.size(); i++)
	{
		if (deviceInfos.at(i)->id == id)
		{
			log->debugLog (QString("Set path(%1) for id: %2").arg(path).arg(id));
			deviceInfos.at(i)->path = path;
			return ;
		}
	}
	// when the method reaches this position than we have an unconfigured device
	// therefore create a new one
	DeviceInformation * info = new DeviceInformation ();
	info->path = path;
	info->id = id;
	info->x = 0.0;
	info->y = 0.0;
	info->z = 0.0;
	deviceInfos.append (info);
	log->infoLog (QString("Added new device with path(%1) for id: %2").arg(path).arg(id));
}
/**
 * @brief parse the data that comes from the OB nodes
 * @param data	the data that is coming from the OB
 * @return
 * 	void
 */
void OpenBeaconUSBStrategy::parseNewData (QString data)
{
	if (data.isEmpty ())
		return ;
	QString receivedPath = reinterpret_cast<OpenBeaconCommunication(*)> (sender ())->getDevicePath ();
	QStringList answerParts = data.split(" ", QString::SkipEmptyParts);
	if (answerParts.at(0) == "Id:")
	{
		setPath (answerParts.at(1).toInt(), receivedPath);
		DeviceInformation * deviceInfo = getDeviceInformation (receivedPath);
		log->infoLog (QString ("device with Id: %1 added.").arg (deviceInfo->id));
		emit newNode (deviceInfo->id, deviceInfo->x, deviceInfo->y, deviceInfo->z);
		return;
	}
	if (answerParts.at (0) == "FIFO" && answerParts.at (1) == "lifetime")
	{
		log->infoLog (QString ("FIFO of >%1< set to %2").arg (receivedPath).arg (answerParts.at (4)));
		return;
	}
	if (answerParts.at(0) == "RX:")
	{
		// if no tag is in reach
		if (answerParts.size () < 2 || answerParts.at(1).isEmpty())
			return ;

		DeviceInformation * deviceInfo = getDeviceInformation (receivedPath);
		if (!deviceInfo)
		{
			log->infoLog (QString ("Received information(%1) from unconfigured device: %2").arg(data).arg(receivedPath));
			return ;
		}

		//RX: 0,2213,3
		// first is the powerlevel (0, 85, 170, 255)
		// second is the tagId
		// third is the count of received packets
		// strength = (powerlevel/85)*10 + (MAXPACKETS - packets)
		// gives us a scale from 0->40
		QStringList tagInfo = answerParts.at(1).split(",", QString::SkipEmptyParts);
		int strength = ((tagInfo.at(0).toInt() / 85) * 10) + (maxPackages - tagInfo.at(2).toInt());
		emit newStrength (deviceInfo->id, tagInfo.at(1).toInt(), strength);
		return;
	}
}
/**
 * @brief returns the number of packages each device stores at maximum (FIFO)
 * @return
 * 	int	number of packages
 */
double OpenBeaconUSBStrategy::getMaximumAxisValue ()
{
	// * 4 because of the 4 different powerlevel
	return (maxPackages * 4);
}
