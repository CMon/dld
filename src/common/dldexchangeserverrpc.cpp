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
#include "dldexchangeserverrpc.h"

#include <QxtTcpConnectionManager>

DLDExchangeServerRPC::DLDExchangeServerRPC(QObject *parent) :
    QObject(parent)
{
	rpcService.attachSignal(this, SIGNAL(updatedMaximumAxisValue(double)), "updatedMaximumAxisValue(double)");
	rpcService.attachSignal(this, SIGNAL(updatedNode(int,double,double,double)), "updatedNode(int,double,double,double)");
	rpcService.attachSignal(this, SIGNAL(updatedPosition(int,int,double,double,double)), "updatedPosition(int,int,double,double,double)");
	rpcService.attachSignal(this, SIGNAL(updatedStrength(int,int,double)), "updatedStrength(int,int,double)");
}

void DLDExchangeServerRPC::setMaximumAxisValue (double maximumAxisValue)
{
	this->maximumAxisValue = maximumAxisValue;

	emit updatedMaximumAxisValue (maximumAxisValue);
}

void DLDExchangeServerRPC::init()
{
	QxtTcpConnectionManager * conManager = new QxtTcpConnectionManager(this);
	conManager->listen();

	rpcService.setConnectionManager(conManager);
}

void DLDExchangeServerRPC::updateNode(int id, double x, double y, double z)
{
	ThreeDPoint pos;
	pos.x = x;
	pos.y = y;
	pos.z = z;

	nodeInfo.insert (id, pos);

	emit updatedNode (id, x, y, z);
}

void DLDExchangeServerRPC::updatePosition(int tagId, int timestamp, double x, double y, double z)
{
	TagPositionInformation	posInfo;
	posInfo.timestamp = timestamp;
	posInfo.x = x;
	posInfo.y = y;
	posInfo.z = z;

	tagPosition.insert (tagId, posInfo);

	emit updatedPosition (tagId, timestamp, x, y, z);
}

void DLDExchangeServerRPC::updateStrength(int deviceId, int tagId, double strength)
{
	StrengthType tmp = tagInfo[tagId];
	tmp.insert (deviceId, strength);
	tagInfo.insert (tagId, tmp);

	emit updatedStrength (deviceId, tagId, strength);
}
