 /*
  * dldExchangeServer.h  - domestic location detection - Exchange Server
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
#ifndef __DLDEXCHANGESERVER_H
#define __DLDEXCHANGESERVER_H

#include "dldExchangeServerStrategy.h"

#include <QList>

class QString;
class QVariant;
class DLDLog;

class DLDDataExchangeServer : public QObject
{
	Q_OBJECT
	public:
		DLDDataExchangeServer (DLDLog * pLog);
		~DLDDataExchangeServer ();

		void addExchangeMethod (int type, QString basePath, QString subPath, int dBusType = DBUS_STRENGTH);
		// class defines:
		static const int TYPE_SSL	= 0;
		static const int TYPE_DBUS	= 1;

		static const int DBUS_STRENGTH	= 0;
		static const int DBUS_POSITION	= 1;

	public slots:
		void		updateNodeOnStrategies (int id, double x, double y, double z);
		void		updatePositionOnStrategies (int tagId, int timestamp, double x, double y, double z);
		void		updateStrengthOnStrategies (int deviceId, int tagId, double strength);
		void		setMaximumAxisValue (double maximumAxisValue);

	private:
		QList<DLDExchangeServerStrategy *>	exchangeStrategies;

		DLDLog *				log;
};

#endif
