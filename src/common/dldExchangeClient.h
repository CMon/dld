 /*
  * dldExchangeClient.h  - domestic location detection - Exchange Client
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
#ifndef __DLDEXCHANGECLIENT_H
#define __DLDEXCHANGECLIENT_H

#include "3dPoint.h"
#include "dldExchangeClientStrategy.h"
#include "tagPositionInformation.h"

class DLDLog;

class DLDDataExchangeClient : public QObject
{
	Q_OBJECT
	public:
		DLDDataExchangeClient (DLDLog * pLog);
		~DLDDataExchangeClient ();

		void		addExchangeMethod (int type, QString basePath, QString subPath, QString interface);
		// class defines:
		static const int TYPE_SSL	= 0;
		static const int TYPE_DBUS	= 1;

		void			refreshTagInfos ();
		QList<int>		getTagList ();
		StrengthType		getStrengths (int tagId);
		TagPositionInformation	getPosition (int tagId);
		double			getMaximumAxisValue ();

		void			refreshNodeInfos ();
		QList<int>		getNodeList ();
		ThreeDPoint		getNodeInformation (int nodeId);

	signals:
		void newStrength (int tagId);
		void newNode (int id);
		void newPosition (int tagId);
		void newMaximumAxisValue (double value);

	private slots:
		void newNodeInfo (int id, double x, double y, double z);
		void newStrengthInfo (int deviceId, int tagId, double strength);
		void newPositionInfo (int tagId, int timestamp, double x, double y, double z);

	private:
		DLDLog *				log;
		QList<DLDExchangeClientStrategy *>	exchangeStrategies;

		QMap<int, ThreeDPoint>			nodeInfo;
		QMap<int, StrengthType>			tagInfo;
		QMap<int, TagPositionInformation>	positionInfo;
		double					maximumAxisValue;
};

#endif
