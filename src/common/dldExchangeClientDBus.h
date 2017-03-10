/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */
#pragma once

#include <common/dldExchangeClientStrategy.h>

#include <QMap>
#include <QtDBus>

class DLDExchangeClientDBus : public DLDExchangeClientStrategy
{
	Q_OBJECT

public:
	DLDExchangeClientDBus (QString connectionBasePath, QString subPath, QString interface);
	~DLDExchangeClientDBus ();

	QString getTagList ();
	QString getNodeList ();
	QString getStrengths (int tagId);
	QString getNodeInfo (int deviceId);
	double getMaximumAxisValue ();

signals:
	void newPosition (int tagId, int timestamp, double x, double y, double z);
	void newStrength (int deviceId, int tagId, double strength);
	void newNode (int id, double x, double y, double z);
	void newMaximumAxisValue (double value);

public slots:
	/**
	 * parse message from incoming signals
	*/
	void parseMessage(const QDBusMessage &message);

private:
	QString serviceName;
	QDBusConnection * dBus;
	QDBusInterface * iFace;
};
