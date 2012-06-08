 /*
  * deviceStrategy.h  - domestic location detection - gain data daemon device strategy interf.
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
#ifndef __DEVICESTRATEGY_H
#define __DEVICESTRATEGY_H

#include "../../common/3dPoint.h"

#include <QObject>

class QString;

/**
 * This class stores the 4 basic information for each device
 */
class DeviceInformation : public ThreeDPoint
{
	public:
		int	id;
		QString path;
};
/**
 * This is an interface for the used strategy pattern for the dvice handling
 */
class DeviceStrategy : public QObject
{
	Q_OBJECT

	public:
		/**
		 * Connects all configured devices (used for starting after adding Devices)
		*/
		virtual void connectDevices () = 0;
		/**
		 * Disconnects all devices, used for closing everything
		*/
		virtual void disconnectDevices () = 0;
		/**
		 * Add a device to the list of devices that should watch for updated informations
		*/
		virtual void addDevice (QString path) = 0;
		/**
		 * Removes a device from the collection
		*/
		virtual void removeDevice (QString path) = 0;
		/**
		 * prints an example for the configuration
		 */
		void printSampleConfig () {};
		/**
		 * returns the maximum value of the device on one axis in one direction
		 */
		virtual double getMaximumAxisValue () = 0;

	signals:
		/**
		 * The signal that should be emitted if a device gets a new strength value of a tag
		*/
		void newStrength (int deviceId, int tagId, double strength);
		/**
		 * The signal that should be emitted when a new device was identified
		 */
		void newNode (int id, double x, double y, double z);

};
#endif
