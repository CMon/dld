/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */
#pragma once

#include <gainData/deviceStrategies/deviceStrategy.h>

#include "ui_hwSimMainWindow.h"

class QSettings;
class QTimer;
class QMainWindow;
class QGraphicsEllipseItem;

class DLDSimulateStrategy  : public DeviceStrategy
{
Q_OBJECT
public:
	DLDSimulateStrategy (QString configName);
	~DLDSimulateStrategy ();
	void connectDevices ();
	void disconnectDevices ();
	void addDevice (QString path);
	void removeDevice (QString path);
	double getMaximumAxisValue ();

private slots:
	void updateNodeData ();
	void updateStrengthData ();
	void updateTimerInterval (int value);
	void updateCircle ();
	void zoom (double zoomBy);
	void updateNodeRange (double value);

private:
	void drawCoordinationSystem ();
	void updateNodeData (int id);
	void updateCircleItem (int id);
	void saveSettings ();
	void loadSettings ();

	QSettings * settings;

	QMainWindow *  mainWindow;
	Ui::mainWindow mainWindowUi;

	QTimer * updateTimer;
	int      fakeTagId;

	QGraphicsEllipseItem * circles[3];
	QGraphicsScene *       scene;
};

