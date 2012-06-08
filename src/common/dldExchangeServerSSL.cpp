 /*
  * dldExchangeServerSSL.cpp  - domestic location detection - Exchange Server SSL Strat
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
/** @class DLDExchangeServerSSL dldExchangeServerSSL.h
 *
 * @author Simon Schaefer
 *
 * @date 18.02.2008
 *
 * @version 1.0
 * <br> Class for the DLD exchange server SSL strategy
 */
#include "dldExchangeServerStrategy.h"
#include "dldExchangeServerSSL.h"
#include "dldLog.h"

#include <QVariant>
#include <QString>
#include <QHostAddress>
#include <QSslSocket>
/**
 * @brief constructor for DLDExchangeSSL class
 * @param logAddress is the pointer of the parents log class
 * @return
 *      void
 */
DLDExchangeServerSSL::DLDExchangeServerSSL (DLDLog * pLog, QString connectionBasePath)
{
	log = pLog;
	connected = false;
}
/**
 * @brief destructor for DLDExchangeSSL class
 * @return
 *      void
 */
DLDExchangeServerSSL::~DLDExchangeServerSSL ()
{
	nodeInfo.clear();
	tagInfo.clear();
}

void DLDExchangeServerSSL::run ()
{
	printf ("TODO\n");
}

void DLDExchangeServerSSL::connect2SSL ()
{
	printf ("TODO\n");
	connected = true;
}

void DLDExchangeServerSSL::disconnectSSL ()
{
	printf ("TODO\n");
	connected = false;
}

void DLDExchangeServerSSL::updateNode (int id, double x, double y, double z)
{
	ThreeDPoint pos;
	pos.x = x;
	pos.y = y;
	pos.z = z;
	nodeMutex.lock ();
	nodeInfo.insert (id, pos);
	nodeMutex.unlock ();
// 	return ("TODO");
}

void DLDExchangeServerSSL::updateStrength (int deviceId, int tagId, double strength)
{
	tagMutex.lock ();
	StrengthType tmp = tagInfo[tagId];
	tmp.insert (deviceId, strength);
	tagInfo.insert (tagId, tmp);
	tagMutex.unlock ();
// 	return ("TODO");
}

void DLDExchangeServerSSL::updatePosition (int tagId, int timestamp, double x, double y, double z)
{

}

void DLDExchangeServerSSL::setMaximumAxisValue (double maximumAxisValue)
{
	this->maximumAxisValue = maximumAxisValue;
}
