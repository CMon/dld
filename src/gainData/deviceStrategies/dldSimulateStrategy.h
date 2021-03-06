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

class QGraphicsEllipseItem;
class QGraphicsScene;
class QMainWindow;
class QSettings;
class QTimer;

class DLDSimulateStrategy  : public DeviceStrategy
{
	Q_OBJECT
public:
	DLDSimulateStrategy (const QString & configName);
	~DLDSimulateStrategy ();
	virtual void connectDevices ();
	virtual void disconnectDevices ();
	virtual void addDevice (const QString & path);
	virtual void removeDevice (const QString & path);
	virtual double getMaximumAxisValue () const;

private slots:
	void updateNodeData (double);
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
	QString fakeTagId;

	QGraphicsEllipseItem * circles[3];
	QGraphicsScene * scene;
};

