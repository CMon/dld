 /*
  * dldGain.h  - domestic location detection - gain data daemon dldGain
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
#ifndef __DLDGAIN_H
#define __DLDGAIN_H

#include "../common/dldExchangeServer.h"

#include "./deviceStrategies/deviceStrategy.h"

#include <QMap>
#include <QList>
#include <QObject>

class QSettings;
class QSocketNotifier;
class DLDLog;

class DLDGain : public QObject
{
	Q_OBJECT

	public:
		DLDGain (int logLevel, QString logFile, QString strategyToUse);
		~DLDGain ();

	private:
		void readConfiguration ();
		void connectDevices ();

		QList<DeviceStrategy *>		devices;
		QMap<int, QMap<int, int> >	tagInformations;
		DLDDataExchangeServer *		dataExchangeServer;
		QSettings *			settings;
		DLDLog *			log;

		bool				running;
		QString				usedStrategy;
};
#endif
