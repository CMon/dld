/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */
/** @class DLDSimulateStrategy dldSimulateStrategy.h
 *
 * @author Simon Schaefer
 *
 * @date 01.04.2008
 *
 * @version 1.0
 * <br>Class for hardware simulation
 */
#include "dldSimulateStrategy.h"

#include <common/dldLog.h>

#include <QGraphicsEllipseItem>
#include <QMainWindow>
#include <QSettings>
#include <QTimer>
#include <QSpinBox>

Q_LOGGING_CATEGORY(SIMULATOR_STRATEGY, "dld.gainData.deviceStrategy.simulator")

/**
 * @brief constructor for DLDHwSim class
 * @param configName The name of the configuration
 */
DLDSimulateStrategy::DLDSimulateStrategy(const QString & configName)
{
	settings = new QSettings (configName, "hardware simulator");
	qCInfo(SIMULATOR_STRATEGY) << QString ("Settings will be stored in: %1.").arg (settings->fileName ());

	// setup interface
	mainWindow = new QMainWindow ();
	mainWindowUi.setupUi (mainWindow);
	scene = new QGraphicsScene ();
	mainWindowUi.nodeGraphView->rotate (-90);
	mainWindowUi.nodeGraphView->setScene (scene);

	connect(mainWindowUi.actionQuit,         &QAction::triggered,                                                          mainWindow, &QMainWindow::close);
	connect(mainWindowUi.updateIntervalSpin, static_cast<void (QSpinBox::*)(int)>(&QSpinBox::valueChanged),                this,       &DLDSimulateStrategy::updateTimerInterval);
	connect(mainWindowUi.maxNodeRangeSpin,   static_cast<void (QDoubleSpinBox::*)(double)>(&QDoubleSpinBox::valueChanged), this,       &DLDSimulateStrategy::updateNodeRange);
	connect(mainWindowUi.zoomSpin,           static_cast<void (QDoubleSpinBox::*)(double)>(&QDoubleSpinBox::valueChanged), this,       &DLDSimulateStrategy::zoom);
	connect(mainWindowUi.node1XSpin,         static_cast<void (QDoubleSpinBox::*)(double)>(&QDoubleSpinBox::valueChanged), this,       static_cast<void (DLDSimulateStrategy::*)(double)>(&DLDSimulateStrategy::updateNodeData));
	connect(mainWindowUi.node1YSpin,         static_cast<void (QDoubleSpinBox::*)(double)>(&QDoubleSpinBox::valueChanged), this,       static_cast<void (DLDSimulateStrategy::*)(double)>(&DLDSimulateStrategy::updateNodeData));
	connect(mainWindowUi.node2XSpin,         static_cast<void (QDoubleSpinBox::*)(double)>(&QDoubleSpinBox::valueChanged), this,       static_cast<void (DLDSimulateStrategy::*)(double)>(&DLDSimulateStrategy::updateNodeData));
	connect(mainWindowUi.node2YSpin,         static_cast<void (QDoubleSpinBox::*)(double)>(&QDoubleSpinBox::valueChanged), this,       static_cast<void (DLDSimulateStrategy::*)(double)>(&DLDSimulateStrategy::updateNodeData));
	connect(mainWindowUi.node3XSpin,         static_cast<void (QDoubleSpinBox::*)(double)>(&QDoubleSpinBox::valueChanged), this,       static_cast<void (DLDSimulateStrategy::*)(double)>(&DLDSimulateStrategy::updateNodeData));
	connect(mainWindowUi.node3YSpin,         static_cast<void (QDoubleSpinBox::*)(double)>(&QDoubleSpinBox::valueChanged), this,       static_cast<void (DLDSimulateStrategy::*)(double)>(&DLDSimulateStrategy::updateNodeData));
	connect(mainWindowUi.node1RadiusSpin,    static_cast<void (QDoubleSpinBox::*)(double)>(&QDoubleSpinBox::valueChanged), this,       &DLDSimulateStrategy::updateCircle);
	connect(mainWindowUi.node2RadiusSpin,    static_cast<void (QDoubleSpinBox::*)(double)>(&QDoubleSpinBox::valueChanged), this,       &DLDSimulateStrategy::updateCircle);
	connect(mainWindowUi.node3RadiusSpin,    static_cast<void (QDoubleSpinBox::*)(double)>(&QDoubleSpinBox::valueChanged), this,       &DLDSimulateStrategy::updateCircle);

	// run the simulation through a timer
	updateTimer = new QTimer (this);
	updateTimer->setSingleShot (false);
	connnct(updateTimer, &QTimer::timeout, this, &DLDSimulateStrategy::updateStrengthData);

	loadSettings ();
}
/**
 * @brief destructor for DLDHwSim class
 * @return
 *      void
 */
DLDSimulateStrategy::~DLDSimulateStrategy ()
{
	if (settings)
	{
		saveSettings ();
		settings->sync ();
		delete (settings);
	}
	if (mainWindow)
		delete (mainWindow);
	if (updateTimer)
		delete (updateTimer);
}
/**
 * @brief load the settings (previously entered values)
 * @return
 *      void
 */
void DLDSimulateStrategy::loadSettings ()
{
	// main window attributes
	mainWindow->move (settings->value("mainWindowPosition", QPoint(200, 200)).toPoint ());
	mainWindow->resize (settings->value("mainWindowSize", QSize(400, 400)).toSize ());

	// node 1 values
	mainWindowUi.node1XSpin->setValue (settings->value("node1X", 0).toDouble ());
	mainWindowUi.node1YSpin->setValue (settings->value("node1Y", 0).toDouble ());
	mainWindowUi.node1RadiusSpin->setValue (settings->value("node1Radius", 0).toDouble ());
	// node 2 values
	mainWindowUi.node2XSpin->setValue (settings->value("node2X", 0).toDouble ());
	mainWindowUi.node2YSpin->setValue (settings->value("node2Y", 0).toDouble ());
	mainWindowUi.node2RadiusSpin->setValue (settings->value("node2Radius", 0).toDouble ());
	// node 3 values
	mainWindowUi.node3XSpin->setValue (settings->value("node3X", 0).toDouble ());
	mainWindowUi.node3YSpin->setValue (settings->value("node3Y", 0).toDouble ());
	mainWindowUi.node3RadiusSpin->setValue (settings->value("node3Radius", 0).toDouble ());

	// additional attributes
	mainWindowUi.updateIntervalSpin->setValue (settings->value("updateInterval", 1).toInt ());
	mainWindowUi.maxNodeRangeSpin->setValue (settings->value("maxNodeRange", 0).toDouble ());
	fakeTagId = settings->value("idToFake", 666).toInt ();
	mainWindowUi.zoomSpin->setValue (settings->value("zoom", 1.0).toDouble ());
}
/**
 * @brief save the settings (entered values)
 * @return
 *      void
 */
void DLDSimulateStrategy::saveSettings ()
{
	// main window attributes
	settings->setValue ("mainWindowPosition", mainWindow->pos());
	settings->setValue ("mainWindowSize", mainWindow->size());
	// node 1 values
	settings->setValue ("node1X", mainWindowUi.node1XSpin->value ());
	settings->setValue ("node1Y", mainWindowUi.node1YSpin->value ());
	settings->setValue ("node1Radius", mainWindowUi.node1RadiusSpin->value ());
	// node 2 values
	settings->setValue ("node2X", mainWindowUi.node2XSpin->value ());
	settings->setValue ("node2Y", mainWindowUi.node2YSpin->value ());
	settings->setValue ("node2Radius", mainWindowUi.node2RadiusSpin->value ());
	// node 3 values
	settings->setValue ("node3X", mainWindowUi.node3XSpin->value ());
	settings->setValue ("node3Y", mainWindowUi.node3YSpin->value ());
	settings->setValue ("node3Radius", mainWindowUi.node3RadiusSpin->value ());
	// additional attributes
	settings->setValue ("updateInterval", mainWindowUi.updateIntervalSpin->value ());
	settings->setValue ("maxNodeRange", mainWindowUi.maxNodeRangeSpin->value ());
	settings->setValue ("idToFake", fakeTagId);
	settings->setValue ("zoom", mainWindowUi.zoomSpin->value ());
}
/**
 * @brief slot: update the timer interval with the value from the GUI
 * @param value	the new value for the interval
 * @return
 *      void
 */
void DLDSimulateStrategy::updateTimerInterval (int value)
{
	updateTimer->setInterval (value * 1000); // * 1000 because msec is given but gui only wants sec
}
/**
 * @brief instead of connecting, the simulation will show the main window and start the timer
 * @return
 *      void
 */
void DLDSimulateStrategy::connectDevices ()
{
	for (int i = 0; i < 3; i++)
	{
		circles[i] = new QGraphicsEllipseItem ();
	}
	circles[0]->setPen (QPen (Qt::red));
	circles[1]->setPen (QPen (Qt::green));
	circles[2]->setPen (QPen (Qt::blue));

	scene->addItem (circles[0]);
	scene->addItem (circles[1]);
	scene->addItem (circles[2]);

	updateTimer->start ();
	mainWindow->show ();
	drawCoordinationSystem ();

	updateNodeData (1);
	updateNodeData (2);
	updateNodeData (3);
}
/**
 * @brief instead of connecting, the simulation will close the window and stop the timer
 * @return
 *      void
 */
void DLDSimulateStrategy::disconnectDevices ()
{
	updateTimer->stop ();
	mainWindow->close ();
}
/**
 * @brief do nothing we are simulating we do not have devices
 * @param path the path to the device
 * @return
 *      void
 */
void DLDSimulateStrategy::addDevice (const QString & path)
{
	Q_UNUSED(path)
	// do nothing
}
/**
 * @brief do nothing we are simulating we do not have devices
 * @param path the path to the device
 * @return
 *      void
 */
void DLDSimulateStrategy::removeDevice (const QString & path)
{
	Q_UNUSED(path)

	// do nothing
}
/**
 * @brief retrieve the maximum axis value
 * @return
 *      int maximum axis value
 */
double DLDSimulateStrategy::getMaximumAxisValue () const
{
	return (mainWindowUi.maxNodeRangeSpin->value ());
}
/**
 * @brief slot: update the strength data every n seconds through the timer
 * @return
 *      void
 */
void DLDSimulateStrategy::updateStrengthData ()
{
	double r1 = mainWindowUi.node1RadiusSpin->value ();
	double r2 = mainWindowUi.node2RadiusSpin->value ();
	double r3 = mainWindowUi.node3RadiusSpin->value ();
	emit newStrength (1, fakeTagId, r1);
	emit newStrength (2, fakeTagId, r2);
	emit newStrength (3, fakeTagId, r3);
	mainWindow->statusBar ()->showMessage (tr("Position updated."));
	qCDebug(SIMULATOR_STRATEGY) << QString("New simulated Strengths: 1: %1, 2: %2, 3: %3").arg(r1).arg(r2).arg(r3);
}
/**
 * @brief slot: update the position data of the nodes, reacts on change of the GUI
 * @return
 *      void
 */
void DLDSimulateStrategy::updateNodeData (double)
{
	int	id;
	QString senderObject = sender ()->objectName ();
	if (senderObject == "node1XSpin" || senderObject == "node1YSpin")
		id = 1;
	else if (senderObject == "node2XSpin" || senderObject == "node2YSpin")
		id = 2;
	else if (senderObject == "node3XSpin" || senderObject == "node3YSpin")
		id = 3;
	updateNodeData (id);
}
/**
 * @brief update the position data of the id
 * @param id	id of the node which data needs to be updated
 * @return
 *      void
 */
void DLDSimulateStrategy::updateNodeData (int id)
{
	double x;
	double y;
	double z = 0.0;
	switch (id)
	{
		case 1:
			x = mainWindowUi.node1XSpin->value ();
			y = mainWindowUi.node1YSpin->value ();
			break;
		case 2:
			x = mainWindowUi.node2XSpin->value ();
			y = mainWindowUi.node2YSpin->value ();
			break;
		case 3:
			x = mainWindowUi.node3XSpin->value ();
			y = mainWindowUi.node3YSpin->value ();
			break;
	}
	updateCircleItem (id);
	emit newNode (id, x, y, z);
	qCDebug(SIMULATOR_STRATEGY) << QString ("Updated Node %1 position: X: %2 Y: %3").arg (id).arg (x).arg (y);
}
/**
 * @brief slot: update the circle position, reacts on a change of the radius, in case of a change of the position the updateNodeData slot will call this method
 * @return
 *      void
 */
void DLDSimulateStrategy::updateCircle ()
{
	QString senderObject = sender ()->objectName ();
	if (senderObject == "node1RadiusSpin")
		updateCircleItem (1);
	else if (senderObject == "node2RadiusSpin")
		updateCircleItem (2);
	else if (senderObject == "node3RadiusSpin")
		updateCircleItem (3);
}
/**
 * @brief slot: updates the circle item
 * @param id	id of the circle to update
 * @return
 *      void
 */
void DLDSimulateStrategy::updateCircleItem (int id)
{
	double mX;
	double mY;
	double width;
	switch (id)
	{
		case 1:
			mX = mainWindowUi.node1XSpin->value () - mainWindowUi.node1RadiusSpin->value ();
			mY = mainWindowUi.node1YSpin->value () - mainWindowUi.node1RadiusSpin->value ();
			width = mainWindowUi.node1RadiusSpin->value () * 2.0;
			break;
		case 2:
			mX = mainWindowUi.node2XSpin->value () - mainWindowUi.node2RadiusSpin->value ();
			mY = mainWindowUi.node2YSpin->value () - mainWindowUi.node2RadiusSpin->value ();
			width = mainWindowUi.node2RadiusSpin->value () * 2.0;
			break;
		case 3:
			mX = mainWindowUi.node3XSpin->value () - mainWindowUi.node3RadiusSpin->value ();
			mY = mainWindowUi.node3YSpin->value () - mainWindowUi.node3RadiusSpin->value ();
			width = mainWindowUi.node3RadiusSpin->value () * 2.0;
			break;
	}
	// because of the rotation the X and Y coordinations are swapped
	if (circles[id - 1])
		circles[id - 1]->setRect (mY, mX, width, width);
}
/**
 * @brief draws the coordination system
 * @return
 *      void
 */
void DLDSimulateStrategy::drawCoordinationSystem ()
{
	int mapAxis = (int) getMaximumAxisValue ();
	for (int i = 10-(mapAxis/2); i < mapAxis/2; i += 10)
	{
		if (i != 0)
			scene->addLine (i, -(mapAxis/2), i, mapAxis/2, QPen(Qt::lightGray));
	}
	for (int i = 10-(mapAxis/2); i < mapAxis/2; i += 10)
	{
		if (i != 0)
			scene->addLine (-(mapAxis/2), i, mapAxis/2, i, QPen(Qt::lightGray));
	}
	scene->addLine (-(mapAxis/2), 0, mapAxis/2, 0, QPen());
	scene->addLine (0, -(mapAxis/2), 0, mapAxis/2, QPen());
}
/**
 * @brief slot: zooms the view
 * @param zoomBy	zoom by this value
 * @return
 *      void
 */
void DLDSimulateStrategy::zoom (double zoomBy)
{
	QMatrix matrix;
	matrix.scale(zoomBy, zoomBy);
	mainWindowUi.nodeGraphView->setMatrix(matrix);
	mainWindowUi.nodeGraphView->rotate (-90);
}
/**
 * @brief slot: updates the node range (redraws the coordination system)
 * @param value	new value of the spin box
 * @return
 *      void
 */
void DLDSimulateStrategy::updateNodeRange (double value)
{
	Q_UNUSED(value)

/*	scene->clear ();
	drawCoordinationSystem ();*/
	qCInfo(SIMULATOR_STRATEGY) << "This change will take effect after restart";
}
