 /*
  * dldExchangeServerSSL.h  - domestic location detection - Exchange Server SSL Strat
  *
  * Copyright (c) by Simon Sch�fer <Simon.Schaefer@koeln.de>
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
#ifndef __DLDEXCHANGESERVERSSL_H
#define __DLDEXCHANGESERVERSSL_H

#include "dldExchangeServerStrategy.h"
#include "strengthType.h"
#include "3dPoint.h"

#include <QMutex>
#include <QThread>

class QString;
class QHostAddress;
class QSslSocket;
class DLDLog;

class DLDExchangeServerSSL : public DLDExchangeServerStrategy, public QThread
{
	Q_OBJECT

	public:
		DLDExchangeServerSSL (DLDLog * pLog, QString connectionBasePath);
		~DLDExchangeServerSSL ();

		void setConnectionBasePath (QString connectionBasePath);
		void run ();

		void updateNode (int id, double x, double y, double z);
		void updateStrength (int deviceId, int tagId, double strength);
		void updatePosition (int tagId, int timestamp, double x, double y, double z);
		void setMaximumAxisValue (double maximumAxisValue);

	private:
		void	connect2SSL ();
		void	disconnectSSL ();
		bool	connected;

		int		firstPort;
		QHostAddress *	hostAddress;

		QSslSocket *	questionSocket;
		QSslSocket *	continueSocket;

		QString			connectionBasePath;
		DLDLog *		log;

		QMutex				nodeMutex;
		QMap<int, ThreeDPoint>		nodeInfo;
		QMutex				tagMutex;
		QMap<int, StrengthType>		tagInfo;

		double				maximumAxisValue;
};

#endif
