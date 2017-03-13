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
#include <common/strengthType.h>

#include <QMap>
#include <QObject>

class QVariant;
class QString;
class QDBusConnection;

class DLDExchangeServerDBusStrength : public QObject, public DLDExchangeServerStrategy
{
Q_CLASSINFO("D-Bus Interface", "dld.provide.strength")
Q_OBJECT

public:
	DLDExchangeServerDBusStrength(const QString & connectionBasePath, const QString & subPath);
	~DLDExchangeServerDBusStrength ();
	void setMaximumAxisValue (double maximumAxisValue);

public slots:
	Q_SCRIPTABLE QString getTagList ();
	Q_SCRIPTABLE QString getNodeList ();
	Q_SCRIPTABLE QString getStrengths (const QString & tagId);
	Q_SCRIPTABLE QString getNodeInfo (const QString & deviceId);
	Q_SCRIPTABLE double getMaximumAxisValue ();

signals:
	void updatedStrength (const QString & deviceId, const QString & tagId, double strength);
	void updatedNode (const QString & id, double x, double y, double z);
	void updatedMaximumAxisValue (double value);

private slots:
	void updateNode (const QString & id, double x, double y, double z);
	void updateStrength (const QString & deviceId, const QString & tagId, double strength);
	void updatePosition (const QString & tagId, int timestamp, double x, double y, double z);

private:
	QMap<QString, QVector3D> nodeInfo;
	QMap<QString, StrengthType> tagInfo;
	QDBusConnection * dBus;
	double maximumAxisValue;
};
