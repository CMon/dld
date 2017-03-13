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
#include <common/tagPositionInformation.h>

#include <QMap>
#include <QObject>

class QVariant;
class QString;
class QDBusConnection;

class DLDExchangeServerDBusPosition : public QObject, public DLDExchangeServerStrategy
{
Q_CLASSINFO("D-Bus Interface", "dld.provide.position")
Q_OBJECT

public:
	DLDExchangeServerDBusPosition(const QString & connectionBasePath, const QString & subPath);
	~DLDExchangeServerDBusPosition ();
	void setMaximumAxisValue (double maximumAxisValue);

public slots:
	Q_SCRIPTABLE QString getTagList () const;
	Q_SCRIPTABLE QString getNodeList () const;
	Q_SCRIPTABLE QString getPosition (const QString & tagId) const;
	Q_SCRIPTABLE QString getNodeInfo (const QString & deviceId) const;
	Q_SCRIPTABLE double getMaximumAxisValue () const;

signals:
	void updatedPosition (const QString & tagId, int timestamp, double x, double y, double z);
	void updatedNode (const QString & id, double x, double y, double z);
	void updatedMaximumAxisValue (double value);

private slots:
	void updateNode (const QString & id, double x, double y, double z);
	void updatePosition (const QString & tagId, int timestamp, double x, double y, double z);
	void updateStrength (const QString & deviceId, const QString & tagId, double strength);

private:
	QMap<QString, QVector3D> nodeInfo;
	QMap<QString, TagPositionInformation> tagPosition;

	QDBusConnection * dBus;
	double maximumAxisValue;
};
