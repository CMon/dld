 /*
  * dldExchangeClientSSL.cpp  - domestic location detection - Exchange Client SSL Strat
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
/** @class DLDExchangeClientSSL dldExchangeClientSSL.h
 *
 * @author Simon Schaefer
 *
 * @date 18.02.2008
 *
 * @version 1.0
 * <br> Class for the DLD exchange client SSL strategy
 */
#include "dldExchangeClientStrategy.h"
#include "dldExchangeClientSSL.h"
#include "dldLog.h"

// TODO: This is just a placeholder class and needs an implementation

DLDExchangeClientSSL::DLDExchangeClientSSL (DLDLog * pLog, QString connectionBasePath)
{
	log = pLog;
}

DLDExchangeClientSSL::~DLDExchangeClientSSL ()
{
	log->debugLog ("TODO");
}

void DLDExchangeClientSSL::run ()
{
	log->debugLog ("TODO");
}

QString DLDExchangeClientSSL::getTagList ()
{
	log->debugLog ("TODO");
	return ("");
}

QString DLDExchangeClientSSL::getNodeList ()
{
	log->debugLog ("TODO");
	return ("");
}

QString DLDExchangeClientSSL::getStrengths (int tagId)
{
	log->debugLog ("TODO");
	return ("");
}

QString DLDExchangeClientSSL::getNodeInfo (int deviceId)
{
	log->debugLog ("TODO");
	return ("");
}

/**
 * @brief calls the getMaximumAxisValue method from the remote
 * @return
 *      int maximum axis value
 */
double DLDExchangeClientSSL::getMaximumAxisValue ()
{
	log->debugLog ("TODO");
	return (0);
}
