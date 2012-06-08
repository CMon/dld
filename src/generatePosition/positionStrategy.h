 /*
  * positionStrategy.h  - domestic location detection - this class stores position strat. related data
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
#ifndef __POSITIONSTRATEGY_H
#define __POSITIONSTRATEGY_H

#include <QList>
#include <QObject>
#include "../common/3dPoint.h"
#include "../common/strengthType.h"

class PositionStrategy : public QObject
{
	Q_OBJECT
	public:
		/**
		 * virtual destructor
		*/
		~PositionStrategy () {};
		/**
		 * calculate the position based on the strengths of the different nodes (nodeId, strength)
		*/
		virtual ThreeDPoint * getPosition (StrengthType strengths, int aNodeId, int bNodeId, int cNodeId, int dNodeId) = 0;
	public slots:
		/**
		 * Add a node to the strategy information
		*/
		virtual void addNode (int id, ThreeDPoint point) = 0;
};

#endif
