 /*
  * dldGeneratePosition.h  - domestic location detection - generate position header
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
#ifndef __DLDGENERATEPOSITION_H
#define __DLDGENERATEPOSITION_H

#include <QObject>
#include <QSettings>
#include <QMap>

#include "../common/dldExchangeServer.h"
#include "../common/dldExchangeClient.h"
#include "../common/tagPositionInformation.h"

#include "positionStrategy.h"

class DLDLog;

class DLDGeneratePosition : public QObject
{
	Q_OBJECT
	public:
		DLDGeneratePosition (int logLevel, QString logFile);
		~DLDGeneratePosition ();

	signals:
		void newTagPos (int tagId, int timestamp, double x, double y, double z);
		void newNodeConnected (int nodeId, double x, double y, double z);

	private slots:
		void newPosition (int tagId);
		void newNode (int nodeId);

	private:
		void					initialPositions ();

		void					readConfiguration ();

		QSettings *				settings;
		DLDDataExchangeServer *			dataExchangeServer;
		DLDDataExchangeClient *			dataExchangeClient;

		DLDLog *				log;
		QMap<int, TagPositionInformation>	tagPositions;
		PositionStrategy *			nodePosition;
		QList<int>				nodeIdList;

// not yet implemented
// 		DLDMap *				mapHandler;
};

#endif
