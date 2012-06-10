/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */
#pragma once

#include <common/3dPoint.h>
#include <common/dldExchangeServerStrategy.h>
#include <common/tagPositionInformation.h>

#include <QMap>
#include <QObject>

class QVariant;
class QString;
class QDBusConnection;
class DLDLog;

class DLDExchangeServerDBusPosition : public QObject, public DLDExchangeServerStrategy
{
Q_CLASSINFO("D-Bus Interface", "dld.provide.position")
Q_OBJECT

public:
	DLDExchangeServerDBusPosition(DLDLog * pLog, QString connectionBasePath, QString subPath);
	~DLDExchangeServerDBusPosition ();
	void setMaximumAxisValue (double maximumAxisValue);

public slots:
	Q_SCRIPTABLE QString getTagList ();
	Q_SCRIPTABLE QString getNodeList ();
	Q_SCRIPTABLE QString getPosition (int tagId);
	Q_SCRIPTABLE QString getNodeInfo (int deviceId);
	Q_SCRIPTABLE double getMaximumAxisValue ();

signals:
	void updatedPosition (int tagId, int timestamp, double x, double y, double z);
	void updatedNode (int id, double x, double y, double z);
	void updatedMaximumAxisValue (double value);

private slots:
	void updateNode (int id, double x, double y, double z);
	void updatePosition (int tagId, int timestamp, double x, double y, double z);
	void updateStrength (int deviceId, int tagId, double strength);

private:
	DLDLog *                          log;

	QMap<int, ThreeDPoint>            nodeInfo;
	QMap<int, TagPositionInformation> tagPosition;

	QDBusConnection *                 dBus;
	double                            maximumAxisValue;
};
