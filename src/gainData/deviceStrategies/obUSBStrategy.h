 /*
  * obUSBStrategy.h  - domestic location detection - gain data daemon USB OB device strategy
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
#ifndef __OBSTRATEGY_H
#define __OBSTRATEGY_H

#include "../../common/obCommunication.h"
#include "deviceStrategy.h"

#include <QMap>
#include <QList>

class QSettings;
class DLDLog;

class OpenBeaconUSBStrategy : public DeviceStrategy
{
	Q_OBJECT

	public:
		OpenBeaconUSBStrategy (QString configName, DLDLog * pLog);
		~OpenBeaconUSBStrategy ();
		void connectDevices ();
		void disconnectDevices ();
		void addDevice (QString path);
		void removeDevice (QString path);
		void connectDevice (QString path);
		void disconnectDevice (QString path);
		double getMaximumAxisValue ();

		DeviceInformation * getDeviceInformation (QString path);
		void loadDevices ();

		void printSampleConfig ();

	private slots:
		void parseNewData (QString data);

	private:
		void readConfiguration ();
		void writeConfiguration ();
		void setPath (int id, QString path);

		QList<DeviceInformation *>			deviceInfos;
		QMap<QString, OpenBeaconCommunication *>	devices;
		QSettings *					settings;
		DLDLog *					log;
		int						maxPackages;
};

#endif
