/*
 * DLDExchangeServerRPC.cpp  - domestic location detection - gain data daemon Exchange Server Strat interface
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
#include <common/dldLog.h>
#include <common/strengthType.h>
#include <common/tagPositionInformation.h>

#include <QMap>
#include <QObject>
#include <QxtRPCService>

class DLDExchangeServerRPC : public QObject, public DLDExchangeServerStrategy
{
	Q_OBJECT
public:
	explicit DLDExchangeServerRPC(QObject *parent = 0);
	void setMaximumAxisValue (double maximumAxisValue);

	void init ();
//public slots:
//	QString getTagList ();
//	QString getNodeList ();
//	QString getStrengths (int tagId);
//	QString getNodeInfo (int deviceId);
//	double getMaximumAxisValue ();

signals:
	void updatedNode (int id, double x, double y, double z);
	void updatedMaximumAxisValue (double value);
	void updatedPosition (int tagId, int timestamp, double x, double y, double z);
	void updatedStrength (int deviceId, int tagId, double strength);

private slots:
	void updateNode (int id, double x, double y, double z);
	void updatePosition (int tagId, int timestamp, double x, double y, double z);
	void updateStrength (int deviceId, int tagId, double strength);

private:
	QxtRPCService  rpcService;

private:
	DLDLog *                          log;

	QMap<int, ThreeDPoint>            nodeInfo;
	QMap<int, TagPositionInformation> tagPosition;
	QMap<int, StrengthType>           tagInfo;

	double                            maximumAxisValue;
};
