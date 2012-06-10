 /*
  * dldExchangeServerDBusStrength.h  - domestic location detection - Exchange Server DBus Strength Strat
  *
  * Copyright (c) by Simon Schäfer <Simon.Schaefer@koeln.de>
  *
  * *************************************************************************
  * *                                                                       *
  * * This program is free software; you can redistribute it and/or modify  *
  * * it under the terms of the GNU General Public License as published by  *
  * * the Free Software Foundation; either version 2 of the License, or     *
  * * (at your option) any later version.                                   *
  * *                                                                       *
  * *************************************************************************
 */
#pragma once

#include <common/3dPoint.h>
#include <common/dldExchangeServerStrategy.h>
#include <common/strengthType.h>

#include <QMap>
#include <QObject>

class QVariant;
class QString;
class QDBusConnection;
class DLDLog;

class DLDExchangeServerDBusStrength : public QObject, public DLDExchangeServerStrategy
{
Q_CLASSINFO("D-Bus Interface", "dld.provide.strength")
Q_OBJECT

public:
	DLDExchangeServerDBusStrength(DLDLog * pLog, QString connectionBasePath, QString subPath);
	~DLDExchangeServerDBusStrength ();
	void setMaximumAxisValue (double maximumAxisValue);

public slots:
	Q_SCRIPTABLE QString getTagList ();
	Q_SCRIPTABLE QString getNodeList ();
	Q_SCRIPTABLE QString getStrengths (int tagId);
	Q_SCRIPTABLE QString getNodeInfo (int deviceId);
	Q_SCRIPTABLE double getMaximumAxisValue ();

signals:
	void updatedStrength (int deviceId, int tagId, double strength);
	void updatedNode (int id, double x, double y, double z);
	void updatedMaximumAxisValue (double value);

private slots:
	void updateNode (int id, double x, double y, double z);
	void updateStrength (int deviceId, int tagId, double strength);
	void updatePosition (int tagId, int timestamp, double x, double y, double z);

private:
	DLDLog *                log;
	QMap<int, ThreeDPoint>  nodeInfo;
	QMap<int, StrengthType> tagInfo;
	QDBusConnection *       dBus;
	double                  maximumAxisValue;
};
