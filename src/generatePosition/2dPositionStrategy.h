/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */
#pragma once

#include <common/3dPoint.h>
#include <generatePosition/positionStrategy.h>

#include <QMap>

class TwoDPositionStrategy : public PositionStrategy
{
	public:
		TwoDPositionStrategy ();
		~TwoDPositionStrategy ();

		ThreeDPoint * getPosition (StrengthType strengths, int aNodeId, int bNodeId, int cNodeId, int dNodeId);

	public slots:
		void addNode (int id, ThreeDPoint point);

	private:
		QMap<int, ThreeDPoint>		nodeInformations;
};
