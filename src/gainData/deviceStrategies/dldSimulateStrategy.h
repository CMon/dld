 /*
  * dldSimulateStrategy.h  - domestic location detection - simulator device strategy
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
#ifndef DLDSIMULATESTRATEGY_H
#define DLDSIMULATESTRATEGY_H

#include "ui_hwSimMainWindow.h"
#include "deviceStrategy.h"

class QSettings;
class QTimer;
class DLDLog;
class QMainWindow;
class QGraphicsEllipseItem;

class DLDSimulateStrategy  : public DeviceStrategy
{
	Q_OBJECT
	public:
		DLDSimulateStrategy (QString configName, DLDLog * pLog);
		~DLDSimulateStrategy ();
		void connectDevices ();
		void disconnectDevices ();
		void addDevice (QString path);
		void removeDevice (QString path);
		double getMaximumAxisValue ();

	private slots:
		void			updateNodeData ();
		void			updateStrengthData ();
		void			updateTimerInterval (int value);
		void			updateCircle ();
		void			zoom (double zoomBy);
		void			updateNodeRange (double value);

	private:
		void			drawCoordinationSystem ();
		void			updateNodeData (int id);
		void			updateCircleItem (int id);
		void			saveSettings ();
		void			loadSettings ();

		DLDLog *		log;
		QSettings *		settings;

		QMainWindow *		mainWindow;
		Ui::mainWindow		mainWindowUi;

		QTimer *		updateTimer;
		int			fakeTagId;

		QGraphicsEllipseItem *	circles[3];
		QGraphicsScene *	scene;
};

#endif
