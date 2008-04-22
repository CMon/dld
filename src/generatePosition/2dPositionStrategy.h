 /*
  * 2dPositionStrategy.h  - domestic location detection - header for 2D position strategy
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
#ifndef __2DPOSITIONSTRATEGY_H
#define __2DPOSITIONSTRATEGY_H

#include <QMap>

#include "positionStrategy.h"
#include "../common/3dPoint.h"

class DLDLog;

class TwoDPositionStrategy : public PositionStrategy
{
	public:
		TwoDPositionStrategy (DLDLog * pLog);
		~TwoDPositionStrategy ();

		ThreeDPoint * getPosition (StrengthType strengths, int aNodeId, int bNodeId, int cNodeId, int dNodeId);

	public slots:
		void addNode (int id, ThreeDPoint point);

	private:
		QMap<int, ThreeDPoint>		nodeInformations;
		DLDLog *			log;
};

#endif
