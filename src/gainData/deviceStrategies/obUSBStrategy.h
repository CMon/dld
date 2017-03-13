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
	OpenBeaconUSBStrategy (const QString & configName);
	~OpenBeaconUSBStrategy ();
	virtual void connectDevices ();
	virtual void disconnectDevices ();
	virtual void addDevice (const QString & path);
	virtual void removeDevice (const QString & path);
	virtual void connectDevice (const QString & path);
	virtual void disconnectDevice (const QString & path);
	virtual double getMaximumAxisValue () const;

	DeviceInformation getDeviceInformation(const QString & path) const;
	void loadDevices ();

	virtual void printSampleConfig () const;

private slots:
	void parseNewData (const QString & data);

private:
	void readConfiguration ();
	void writeConfiguration ();
	void setPath (int id, QString path);

	QList<DeviceInformation> deviceInfos;
	QMap<QString, OpenBeaconCommunication *> devices;
	QSettings * settings;
	int maxPackages;
};
