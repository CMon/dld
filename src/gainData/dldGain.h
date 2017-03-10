/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */
#pragma once

#include <common/dldExchangeServer.h>
#include <gainData/deviceStrategies/deviceStrategy.h>

#include <QMap>
#include <QList>
#include <QObject>

class QSettings;
class QSocketNotifier;

class DLDGain : public QObject
{
	Q_OBJECT

public:
	DLDGain (const QString & strategyToUse);
	~DLDGain ();

private:
	void readConfiguration ();
	void connectDevices ();

	QList<DeviceStrategy *> devices;
	QMap<int, QMap<int, int> > tagInformations;
	DLDDataExchangeServer * dataExchangeServer;
	QSettings * settings;

	QString usedStrategy;
};
