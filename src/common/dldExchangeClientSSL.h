 /*
  * dldExchangeClientSSL.h  - domestic location detection - Exchange Client SSL Strat
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
#ifndef __DLDEXCHANGECLIENTSSL_H
#define __DLDEXCHANGECLIENTSSL_H

#include "dldExchangeClientStrategy.h"
#include "3dPoint.h"

#include <QThread>
#include <QMutex>

class QString;
class QHostAddress;
class QSslSocket;
class DLDLog;

class DLDExchangeClientSSL : public DLDExchangeClientStrategy, public QThread
{
	Q_OBJECT
	public:
		DLDExchangeClientSSL (DLDLog * pLog, QString connectionBasePath);
		~DLDExchangeClientSSL ();

		void run ();

		QString getTagList ();
		QString getNodeList ();
		QString getStrengths (int tagId);
		QString getNodeInfo (int deviceId);
		double	getMaximumAxisValue ();

	private:
		void				connect2SSL ();
		void				disconnectSSL ();
		bool				connected;

		int				firstPort;
		QHostAddress *			hostAddress;

		QSslSocket *			questionSocket;
		QSslSocket *			continueSocket;

		DLDLog *			log;

		QMutex				nodeMutex;
		QMap<int, ThreeDPoint>		nodeInfo;
		QMutex				tagMutex;
		QMap<int, StrengthType>		tagInfo;
};
#endif
