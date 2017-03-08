/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
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

#include <common/dldLog.h>

#include <math.h>

Q_LOGGING_CATEGORY(GENERATE_POSITION_2DSTRAT, "dld.generatePosition.2dStrategy")


/**
 * @brief constructor for TwoDPositionStrategy class
 */
TwoDPositionStrategy::TwoDPositionStrategy ()
{
}
/**
 * @brief destructor for TwoDPositionStrategy class
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
	qCDebug(GENERATE_POSITION_2DSTRAT) << QString ("xA: %1 yA: %2 rA: %3").arg(xA).arg(yA).arg(rA);

	double xB = nodeInformations[bNodeId].x;
	double yB = nodeInformations[bNodeId].y;
	double rB = strengths[bNodeId];
	qCDebug(GENERATE_POSITION_2DSTRAT) << QString ("xB: %1 yB: %2 rB: %3").arg(xB).arg(yB).arg(rB);

	double xC = nodeInformations[cNodeId].x;
	double yC = nodeInformations[cNodeId].y;
	double rC = strengths[cNodeId];
	qCDebug(GENERATE_POSITION_2DSTRAT) << QString ("xC: %1 yC: %2 rC: %3").arg(xC).arg(yC).arg(rC);

	double dx	= (xB) - (xA);
	double dy	= (yB) - (yA);
	double d	= sqrt (pow (dx, 2.0) + pow (dy, 2.0));
	qCDebug(GENERATE_POSITION_2DSTRAT) << QString ("dx: %1 dy: %2 d: %3").arg(dx).arg(dy).arg(d);

	double a	= (pow (rA, 2.0) - pow (rB, 2.0) + pow (d, 2.0)) / (2.0 * (d));
	double h2	= pow (rA, 2.0) - pow (a, 2.0);
	qCDebug(GENERATE_POSITION_2DSTRAT) << QString ("a: %1 h2: %2").arg(a).arg(h2);

	if (h2 < 0)
	{
		return (NULL);
	}

	// h2 >= 0 at least one point
	double h	= sqrt (h2);
	qCDebug(GENERATE_POSITION_2DSTRAT) << QString ("h: %3").arg(h);

	double x1	= (xA) + ((a)/(d)) * (dx) - ((h)/(d)) * (dy);
	double y1	= (yA) + ((a)/(d)) * (dy) + ((h)/(d)) * (dx);
	qCDebug(GENERATE_POSITION_2DSTRAT) << QString ("Interception Coordination 1: I1(%1, %2)").arg(x1).arg(y1);

	if (h == 0)
	{
		point->x = x1;
		point->y = y1;
		return (point);
	}

	// h2 > 0 we need to calculate a second point ant compare to the 3. circle
	double x2	= (xA) + ((a)/(d)) * (dx) + ((h)/(d)) * (dy);
	double y2	= (yA) + ((a)/(d)) * (dy) - ((h)/(d)) * (dx);
	qCDebug(GENERATE_POSITION_2DSTRAT) << QString ("Interception Coordination 2: I2(%1, %2)").arg(x2).arg(y2);

	double distP1	= sqrt (pow ((x1)-(xC),2.0) + pow ((y1)-(yC),2.0));
	double distP2	= sqrt (pow ((x2)-(xC),2.0) + pow ((y2)-(yC),2.0));
	qCDebug(GENERATE_POSITION_2DSTRAT) << QString ("distP1: %1 distP2: %2").arg(distP1).arg(distP2);

	// the distance (distP1 or distP2) which is closer to the value of rC is the winner
	double absolutDistP1 = fabs (distP1 - rC);
	double absolutDistP2 = fabs (distP2 - rC);
	double smaller = qMin (absolutDistP1, absolutDistP2);
	if (smaller == absolutDistP1)
	{
		qCDebug(GENERATE_POSITION_2DSTRAT) << "I1 is the choosen one";
		point->x = x1;
		point->y = y1;
	}
	else if (smaller == absolutDistP2)
	{
		qCDebug(GENERATE_POSITION_2DSTRAT) << "I2 is the choosen one";
		point->x = x2;
		point->y = y2;
	}
	else
		qCDebug(GENERATE_POSITION_2DSTRAT) << "Something went horrible wrong";
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
	qCDebug(GENERATE_POSITION_2DSTRAT) << QString("Add new node to strategy, id: %1").arg(id);
	nodeInformations.insert (id, point);
}
