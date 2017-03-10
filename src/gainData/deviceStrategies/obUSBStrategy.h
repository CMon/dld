/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */
#pragma once

#include <common/obCommunication.h>
#include <gainData/deviceStrategies/deviceStrategy.h>

#include <QMap>
#include <QList>

class QSettings;

class OpenBeaconUSBStrategy : public DeviceStrategy
{
	Q_OBJECT

public:
	OpenBeaconUSBStrategy (QString configName);
	~OpenBeaconUSBStrategy ();
	void connectDevices ();
	void disconnectDevices ();
	void addDevice (QString path);
	void removeDevice (QString path);
	void connectDevice (QString path);
	void disconnectDevice (QString path);
	double getMaximumAxisValue ();

	DeviceInformation getDeviceInformation(QString path);
	void loadDevices ();

	void printSampleConfig ();

private slots:
	void parseNewData (QString data);

private:
	void readConfiguration ();
	void writeConfiguration ();
	void setPath (int id, QString path);

	QList<DeviceInformation> deviceInfos;
	QMap<QString, OpenBeaconCommunication *> devices;
	QSettings * settings;
	int maxPackages;
};
