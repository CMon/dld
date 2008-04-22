 /*
  * dldExchangeServerStrategy.cpp  - domestic location detection - gain data daemon Exchange Server Strat interface
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
#ifndef __DLDEXCHANGESTRATEGYSERVER_H
#define __DLDEXCHANGESTRATEGYSERVER_H

#include <QObject>

class QString;

/**
 * This is an interface for the exchange strategies
*/
class DLDExchangeServerStrategy : public QObject
{
	Q_OBJECT
	public:
		/**
		 * std. destructor
		 */
		~DLDExchangeServerStrategy (){};
		/**
		 * Used to update the node data
		*/
		virtual void updateNode (int id, double x, double y, double z) = 0;
		/**
		 * Used to update the tag position data
		 */
		virtual void updatePosition (int tagId, int timestamp, double x, double y, double z) = 0;
		/**
		 * Used to update the tag strength data
		 */
		virtual void updateStrength (int deviceId, int tagId, double strength) = 0;
		/**
		 * Set the maximum axis value of the device strategy
		*/
		virtual void setMaximumAxisValue (double maximumAxisValue) = 0;
};

#endif
