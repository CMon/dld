 /*
  * dldExchangeClientStrategy.h  - domestic location detection - Exchange Client Strat inerface
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
#ifndef __DLDEXCHANGECLIENTSTRATEGY_H
#define __DLDEXCHANGECLIENTSTRATEGY_H

#include <QObject>
#include <QMap>

#include "strengthType.h"
class QString;

class DLDExchangeClientStrategy : public QObject
{
	Q_OBJECT
	public:
		/**
		 * std. destructor
		*/
		~DLDExchangeClientStrategy() {};
		/**
		 * retrieve the tag list from the data exchange server
		*/
		virtual QString getTagList () = 0;
		/**
		 * retrieve the node list from the data exchange server
		*/
		virtual QString getNodeList () = 0;
		/**
		 * retrieve the tags strength string from the data exchange server
		*/
		virtual QString getStrengths (int tagId) = 0;
		/**
		 * retrieve the node information string from the data exchange server
		*/
		virtual QString getNodeInfo (int deviceId) = 0;
		/**
		 * Get the maximum axis value of the used device
		 */
		virtual double getMaximumAxisValue () = 0;

	signals:
		/**
		 * send when new strength information arrives at the client side of the dbus
		*/
		void newStrength (int deviceId, int tagId, double strength);
		/**
		 * send when new node information arrives at the client side of the dbus
		 */
		void newNode (int id, double x, double y, double z);
};

#endif
