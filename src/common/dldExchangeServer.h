/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */
#pragma once

#include <common/dldExchangeServerStrategy.h>

#include <QObject>
#include <QList>

class QString;
class QVariant;
class DLDLog;

class DLDDataExchangeServer : public QObject
{
Q_OBJECT
public:
	DLDDataExchangeServer (DLDLog * pLog);
	~DLDDataExchangeServer ();

	void addExchangeMethod (int type, QString basePath, QString subPath, int dBusType = DBUS_STRENGTH);
	// class defines:
	static const int TYPE_DBUS  = 1;

	static const int DBUS_STRENGTH = 0;
	static const int DBUS_POSITION = 1;

public slots:
	void updateNodeOnStrategies (int id, double x, double y, double z);
	void updatePositionOnStrategies (int tagId, int timestamp, double x, double y, double z);
	void updateStrengthOnStrategies (int deviceId, int tagId, double strength);
	void setMaximumAxisValue (double maximumAxisValue);

private:
	QList<DLDExchangeServerStrategy *> exchangeStrategies;
	DLDLog *                           log;
};
