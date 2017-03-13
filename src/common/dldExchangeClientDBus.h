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
	DLDExchangeClientDBus (const QString & connectionBasePath, const QString & subPath, const QString & interface);
	~DLDExchangeClientDBus ();

	virtual QString getTagList ();
	virtual QString getNodeList ();
	virtual QString getStrengths (const QString & tagId) const;
	virtual QString getNodeInfo (const QString & deviceId) const;
	virtual double getMaximumAxisValue ();

signals:
	void newPosition (const QString & tagId, int timestamp, double x, double y, double z);
	void newStrength (const QString & deviceId, const QString & tagId, double strength);
	void newNode (const QString & id, double x, double y, double z);
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
