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
#include <common/strengthType.h>

#include <QList>
#include <QObject>

class PositionStrategy : public QObject
{
	Q_OBJECT
	public:
		/**
		 * virtual destructor
		*/
		~PositionStrategy () {}
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

