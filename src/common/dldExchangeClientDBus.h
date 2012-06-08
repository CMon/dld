 /*
  * dldExchangeClientDBus.h  - domestic location detection - Exchange Client DBus Strat
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
#ifndef __DLDEXCHANGECLIENTDBUS_H
#define __DLDEXCHANGECLIENTDBUS_H

#include "dldExchangeClientStrategy.h"
#include "3dPoint.h"

#include <QMap>
#include <QtDBus>

class DLDLog;

class DLDExchangeClientDBus : public DLDExchangeClientStrategy
{
	Q_OBJECT

	public:
		DLDExchangeClientDBus (DLDLog * pLog, QString connectionBasePath, QString subPath, QString interface);
		~DLDExchangeClientDBus ();

		QString getTagList ();
		QString getNodeList ();
		QString getStrengths (int tagId);
		QString getNodeInfo (int deviceId);
		double	getMaximumAxisValue ();

	signals:
		void newPosition (int tagId, int timestamp, double x, double y, double z);
		void newStrength (int deviceId, int tagId, double strength);
		void newNode (int id, double x, double y, double z);
		void newMaximumAxisValue (double value);

	public slots:
		/**
		 * parse message from incoming signals
		*/
		void parseMessage(const QDBusMessage &message);

	private:
		DLDLog *			log;
		QString				serviceName;
		QDBusConnection *		dBus;
		QDBusInterface *		iFace;
};

#endif
