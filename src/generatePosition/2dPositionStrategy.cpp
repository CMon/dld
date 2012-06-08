 /*
  * 2dPositionStrategy.cpp  - domestic location detection - source for 2D position strategy
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
/** @class TwoDPositionStrategy 2dPositionStrategy.h
 *
 * @author Simon Schaefer
 *
 * @date 24.02.2008
 *
 * @version 1.0
 * <br> Class for the calculation of the position in a 2D world
 */
#include "2dPositionStrategy.h"
#include "../common/dldLog.h"
#include <math.h>

/**
 * @brief constructor for TwoDPositionStrategy class
 * @param pLog is the pointer of the parents log class
 * @return
 *      void
 */
TwoDPositionStrategy::TwoDPositionStrategy (DLDLog * pLog)
{
	log = pLog;
}
/**
 * @brief destructor for TwoDPositionStrategy class
 * @return
 *      void
 */
TwoDPositionStrategy::~TwoDPositionStrategy ()
{
	nodeInformations.clear ();
}
/**
 * @brief calculate the position of the tag (for calculation formula see http://kowalski.s4f.eu/addt/2kreise.html)
 * @param strengths The strengths on which the calculation is based
 * @return
 *      ThreeDPoint	a pointer to the position of the tag
 */
ThreeDPoint * TwoDPositionStrategy::getPosition (StrengthType strengths, int aNodeId, int bNodeId, int cNodeId, int dNodeId)
{
	ThreeDPoint * point = new ThreeDPoint ();
	point->x = 0;
	point->y = 0;
	point->z = 0;
	// if there are less then 3 nodes forget the position thing
	if (strengths.size() < 3)
		return (NULL);

	double xA = nodeInformations[aNodeId].x;
	double yA = nodeInformations[aNodeId].y;
	double rA = strengths[aNodeId];
	log->debugLog (QString ("xA: %1 yA: %2 rA: %3").arg(xA).arg(yA).arg(rA));

	double xB = nodeInformations[bNodeId].x;
	double yB = nodeInformations[bNodeId].y;
	double rB = strengths[bNodeId];
	log->debugLog (QString ("xB: %1 yB: %2 rB: %3").arg(xB).arg(yB).arg(rB));

	double xC = nodeInformations[cNodeId].x;
	double yC = nodeInformations[cNodeId].y;
	double rC = strengths[cNodeId];
	log->debugLog (QString ("xC: %1 yC: %2 rC: %3").arg(xC).arg(yC).arg(rC));

	double dx	= (xB) - (xA);
	double dy	= (yB) - (yA);
	double d	= sqrt (pow (dx, 2.0) + pow (dy, 2.0));
	log->debugLog (QString ("dx: %1 dy: %2 d: %3").arg(dx).arg(dy).arg(d));

	double a	= (pow (rA, 2.0) - pow (rB, 2.0) + pow (d, 2.0)) / (2.0 * (d));
	double h2	= pow (rA, 2.0) - pow (a, 2.0);
	log->debugLog (QString ("a: %1 h2: %2").arg(a).arg(h2));

	if (h2 < 0)
	{
		return (NULL);
	}

	// h2 >= 0 at least one point
	double h	= sqrt (h2);
	log->debugLog (QString ("h: %3").arg(h));

	double x1	= (xA) + ((a)/(d)) * (dx) - ((h)/(d)) * (dy);
	double y1	= (yA) + ((a)/(d)) * (dy) + ((h)/(d)) * (dx);
	log->debugLog (QString ("Interception Coordination 1: I1(%1, %2)").arg(x1).arg(y1));

	if (h == 0)
	{
		point->x = x1;
		point->y = y1;
		return (point);
	}

	// h2 > 0 we need to calculate a second point ant compare to the 3. circle
	double x2	= (xA) + ((a)/(d)) * (dx) + ((h)/(d)) * (dy);
	double y2	= (yA) + ((a)/(d)) * (dy) - ((h)/(d)) * (dx);
	log->debugLog (QString ("Interception Coordination 2: I2(%1, %2)").arg(x2).arg(y2));

	double distP1	= sqrt (pow ((x1)-(xC),2.0) + pow ((y1)-(yC),2.0));
	double distP2	= sqrt (pow ((x2)-(xC),2.0) + pow ((y2)-(yC),2.0));
	log->debugLog (QString ("distP1: %1 distP2: %2").arg(distP1).arg(distP2));

	// the distance (distP1 or distP2) which is closer to the value of rC is the winner
	double absolutDistP1 = fabs (distP1 - rC);
	double absolutDistP2 = fabs (distP2 - rC);
	double smaller = qMin (absolutDistP1, absolutDistP2);
	if (smaller == absolutDistP1)
	{
		log->debugLog ("I1 is the choosen one");
		point->x = x1;
		point->y = y1;
	}
	else if (smaller == absolutDistP2)
	{
		log->debugLog ("I2 is the choosen one");
		point->x = x2;
		point->y = y2;
	}
	else
		log->infoLog ("Something went horrible wrong");
	return (point);
}
/**
 * @brief add a node to the information map
 * @param information the informations of the node
 * @return
 *      void
 */
void TwoDPositionStrategy::addNode (int id, ThreeDPoint point)
{
	log->debugLog (QString("Add new node to strategy, id: %1").arg(id));
	nodeInformations.insert (id, point);
}
