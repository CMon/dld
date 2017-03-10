/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */
#pragma once

#include <gainData/deviceStrategies/deviceStrategy.h>

#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QSettings>
#include <QTimer>
#include <QVector3D>

class RouterInfo
{
public:
	int id;
	QVector3D position;
	QNetworkRequest networkRequest;
};

class DDWRTStrategy : public DeviceStrategy
{
public:
	DDWRTStrategy(const QString & configName);

	void connectDevices ();
	void disconnectDevices ();
#warning fixme: think about the addDevice, removeDevice if they are needed in the strategy or at all
	void addDevice (const QString & path);
	void removeDevice (const QString & path);

	void printSampleConfig ();
	double getMaximumAxisValue () { return maximumDBValue; }

private slots:
	void checkRouters();

private:
	void readConfiguration ();

private:
	QHash<int, RouterInfo> routers;

	QSettings settings;
	int checkFrequenzy;
	int maximumDBValue;

	QNetworkAccessManager nam;
	QTimer checkTimer;
};
