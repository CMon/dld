/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */
/** @class DLDShowPos dldShowPos.h
 *
 * @author Simon Schaefer
 *
 * @date 16.03.2008
 *
 * @version 1.0
 * <br> Class for the DLD show position class
 */
#include "dldShowPos.h"

#include <common/dldLog.h>
#include <common/dldMapScene.h>

#include <QtGui>

#include "ui_selectConnectionDialog.h"

/**
 * @brief constructor for DLDShowPos class
 * @param logLevel verboxity level for logging
 * @param logFile file for logging
 * @return
 *      void
 */
DLDShowPos::DLDShowPos (int logLevel, QString logFile)
	: currentConnectionType(CONN_NONE)
{
	log = new DLDLog ();
	log->setLogLevel (logLevel);
	if (!logFile.isEmpty())
		log->setLogFile (logFile);

	mapScene = new DLDMapScene (log);

	mapView = new QGraphicsView ();
	mapView->setObjectName ("mapView");
	mapView->rotate (-90);
	mapView->setScene (mapScene);

	connect (mapScene, SIGNAL (mouseEnterTag (int, int, int)), this, SLOT (mouseEnterTag (int, int, int)));
	connect (mapScene, SIGNAL (mouseLeaveTag ()), this, SLOT (mouseLeaveTag ()));
	connect (mapScene, SIGNAL (mouseMoveOverTag (int, int, int)), this, SLOT (mouseMoveOverTag (int, int, int)));

	tagInfoDialog = new TagInfoDialog (this);

	exchangeClient = new DLDDataExchangeClient (log);

	setWindowTitle (tr("DLD - Show Position application"));

	createActions ();
	createMenus ();
	createToolBars ();
	createStatusBar ();
	createDocks ();

	setCentralWidget (mapView);

	readSettings ();
// 	connect (personInfoDock, SIGNAL (visibilityChanged (bool)), showPersonInfoAct, SLOT (setChecked (bool)));
// 	connect (databaseListDock, SIGNAL (visibilityChanged (bool)), showDatabaseListDockAct, SLOT (setChecked (bool)));

	connect (this, SIGNAL (newDataNeeded (int)), this, SLOT (getNewData (int)));
}
/**
 * @brief destructor for DLDShowPos class
 * @return
 *      void
 */
DLDShowPos::~DLDShowPos ()
{
	if (exchangeClient)
		delete (exchangeClient);
	if (tagInfoDialog)
		delete (tagInfoDialog);
	if (mapView)
		delete (mapView);
}
/**
 * @brief overloaded function for close event
 * @return
 *      void
 */
void DLDShowPos::closeEvent (QCloseEvent *)
{
	writeSettings ();
}
/**
 * @brief slot: prints the about message for the show position application
 * @return
 *      void
 */
void DLDShowPos::about ()
{
	QMessageBox::about(this, tr("About Show Position"),
			   tr("Show position is a tool to visualize the current position of the tag."));
}
/**
 * @brief creates all actions for the application
 * @return
 *      void
 */
void DLDShowPos::createActions ()
{
	loadMapAct = new QAction (QIcon(":/icons/open.png"), tr("&Load map ..."), this);
	loadMapAct->setShortcut (tr("Ctrl+L"));
	loadMapAct->setStatusTip (tr("Load a map package"));
	connect (loadMapAct, SIGNAL (triggered ()), this, SLOT (loadMap ()));

	connectToGenPosAct = new QAction (QIcon(":/icons/connect.png"), tr("&Connect to Generate Position ..."), this);
	connectToGenPosAct->setShortcut (tr("Ctrl+C"));
	connectToGenPosAct->setStatusTip (tr("Connect to Generate Position..."));
	connect (connectToGenPosAct, SIGNAL (triggered ()), this, SLOT (connectToGenPos ()));
	connect (this, SIGNAL (connectedToGenPos (bool)), connectToGenPosAct, SLOT (setDisabled (bool)));

	disconnectFromGenPosAct = new QAction (QIcon(":/icons/disconnect.png"), tr("Disconnect from Generate Position"), this);
	disconnectFromGenPosAct->setShortcut (tr("Ctrl+W"));
	disconnectFromGenPosAct->setStatusTip (tr("Disconnects current view"));
	disconnectFromGenPosAct->setEnabled (false);
	connect (disconnectFromGenPosAct, SIGNAL (triggered ()), this, SLOT (disconnectFromGenPos ()));
	connect (this, SIGNAL (connectedToGenPos (bool)), disconnectFromGenPosAct, SLOT (setEnabled (bool)));

	connectToDBAct = new QAction (QIcon(":/icons/db-connect.png"), tr("Connect to database..."), this);
	connectToDBAct->setShortcut (tr("Ctrl+S"));
	connectToDBAct->setStatusTip (tr("Connect to database..."));
	connect (connectToDBAct, SIGNAL (triggered ()), this, SLOT (connectDialog ()));
	connect (this, SIGNAL (connectedToDatabase (bool)), connectToDBAct, SLOT (setDisabled (bool)));

	disconnectFromDBAct = new QAction (QIcon(":/icons/db-disconnect.png"), tr("Disconnect from database"), this);
	disconnectFromDBAct->setStatusTip (tr("Disconnects from database"));
	disconnectFromDBAct->setEnabled (false);
	connect (disconnectFromDBAct, SIGNAL (triggered ()), this, SLOT (disconnectFromDB ()));
	connect (this, SIGNAL (connectedToDatabase (bool)), disconnectFromDBAct, SLOT (setEnabled (bool)));

	showPersonInfoAct = new QAction (tr("Show Person Information dock"), this);
	showPersonInfoAct->setShortcut (tr("Ctrl+P"));
	showPersonInfoAct->setStatusTip (tr("Show Person Information dock"));
	showPersonInfoAct->setCheckable (true);
	connect (showPersonInfoAct, SIGNAL (changed ()), this, SLOT (showPersonInfo ()));

	showDatabaseListDockAct = new QAction (tr("Show Database List dock"), this);
	showDatabaseListDockAct->setShortcut (tr("Ctrl+D"));
	showDatabaseListDockAct->setStatusTip (tr("Show Database List dock"));
	showDatabaseListDockAct->setCheckable (true);
	connect (showDatabaseListDockAct, SIGNAL (changed ()), this, SLOT (showDatabaseListDock ()));

	showPersonInfoHintAct = new QAction (tr("Show Mouse-over Person Information"), this);
	showPersonInfoHintAct->setStatusTip (tr("Show Mouse-over Person Information"));
	showPersonInfoHintAct->setCheckable (true);

	exitAct = new QAction (tr("&Quit"), this);
	exitAct->setShortcut (tr("Ctrl+Q"));
	exitAct->setStatusTip (tr("Exit the application"));
	connect (exitAct, SIGNAL (triggered ()), this, SLOT (close ()));

	aboutAct = new QAction (tr("&About"), this);
	aboutAct->setStatusTip (tr("Show the application's About box"));
	connect (aboutAct, SIGNAL (triggered ()), this, SLOT (about ()));

	aboutQtAct = new QAction (tr("About &Qt"), this);
	aboutQtAct->setStatusTip (tr("Show the Qt library's About box"));
	connect (aboutQtAct, SIGNAL (triggered ()), qApp, SLOT (aboutQt ()));
}
/**
 * @brief creates the main menu for the application
 * @return
 *      void
 */
void DLDShowPos::createMenus ()
{
	fileMenu = menuBar ()->addMenu (tr("&File"));
	fileMenu->addAction (loadMapAct);
	fileMenu->addAction (connectToGenPosAct);
	fileMenu->addAction (disconnectFromGenPosAct);
	fileMenu->addSeparator ();
	fileMenu->addAction (connectToDBAct);
	fileMenu->addAction (disconnectFromDBAct);
	fileMenu->addSeparator ();
	fileMenu->addAction (exitAct);

	showMenu = menuBar ()->addMenu (tr("&Show"));
	showMenu->addAction (showPersonInfoAct);
	showMenu->addAction (showPersonInfoHintAct);
	showMenu->addAction (showDatabaseListDockAct);

	menuBar ()->addSeparator ();
	helpMenu = menuBar ()->addMenu (tr("&Help"));
	helpMenu->addAction (aboutAct);
	helpMenu->addAction (aboutQtAct);
}
/**
 * @brief creates the toolbar(s) for the application
 * @return
 *      void
 */
void DLDShowPos::createToolBars ()
{
	toolBar = addToolBar (tr("bar"));
	toolBar->addAction (loadMapAct);
	toolBar->addSeparator ();
	toolBar->addAction (connectToGenPosAct);
	toolBar->addAction (disconnectFromGenPosAct);
	toolBar->addSeparator ();
	toolBar->addAction (connectToDBAct);
	toolBar->addAction (disconnectFromDBAct);
	toolBar->addSeparator ();

	zoomLabel = new QLabel(tr("Zoom:"));
	zoomSpin = new QDoubleSpinBox ();
	zoomSpin->setDecimals (1);
	zoomSpin->setMinimum (0.0);
	zoomSpin->setSingleStep (0.5);
	zoomSpin->setValue (1.0);
	connect (zoomSpin, SIGNAL (valueChanged (double)), this, SLOT (zoom (double)));

	toolBar->addWidget (zoomLabel);
	toolBar->addWidget (zoomSpin);
}
/**
 * @brief creates the statusbar for the application
 * @return
 *      void
 */
void DLDShowPos::createStatusBar ()
{
	statusBar ()->showMessage (tr("Ready"));
}
/**
 * @brief creates the docks that can be used in the application
 * @return
 *      void
 */
void DLDShowPos::createDocks ()
{
	QWidget *       personInfoWidget = new QWidget;
	personInfoDock = new QDockWidget(tr("Person Information"), this);
	personInfoUi.setupUi (personInfoWidget);
	personInfoDock->setWidget (personInfoWidget);
	personInfoDock->installEventFilter( this );
	addDockWidget(Qt::RightDockWidgetArea, personInfoDock);

	QWidget *       databaseListDockWidget = new QWidget;
	databaseListDock = new QDockWidget(tr("Database list"), this);
	databaseListDockUi.setupUi (databaseListDockWidget);
	databaseListDock->setWidget (databaseListDockWidget);
	databaseListDock->installEventFilter( this );
	addDockWidget(Qt::RightDockWidgetArea, databaseListDock);
	QStringList tableHeader;
	tableHeader << tr ("Tag ID") << tr ("Name") << tr ("Prename") << tr ("Color") << tr ("Picture") << tr ("Description");
	databaseListDockUi.personTableWidget->setHorizontalHeaderLabels (tableHeader);
	connect (databaseListDockUi.refreshButton, SIGNAL (pressed ()), this, SLOT (refreshEntries ()));
	connect (this, SIGNAL (connectedToDatabase (bool)), databaseListDockUi.refreshButton, SLOT (setEnabled (bool)));
}
/**
 * @brief reads the settings and configures the application in an appropiate way
 * @return
 *      void
 */
void DLDShowPos::readSettings ()
{
	settings = new QSettings ("DLD", "Show position application");
	log->infoLog (QString ("Settings will be stored in: %1.").arg (settings->fileName ()));
	QPoint pos = settings->value("pos", QPoint(200, 200)).toPoint ();
	QSize size = settings->value("size", QSize(400, 400)).toSize ();
	zoomSpin->setValue (settings->value("zoomLevel", 1.0).toDouble ());

	bool showPersInfo = settings->value("showPersonInfo", false).toBool();
	bool showDatabaseListDock = settings->value("showDatabaseListDock", false).toBool();
	showPersonInfoHintAct->setChecked (settings->value("showPersonInfoHint", true).toBool());

	resize(size);
	move(pos);
	showPersonInfoAct->setChecked (showPersInfo);
	if (showPersInfo)
		personInfoDock->show();
	else
		personInfoDock->hide();

	showDatabaseListDockAct->setChecked (showDatabaseListDock);
	if (showDatabaseListDock)
		databaseListDock->show();
	else
		databaseListDock->hide();
}
/**
 * @brief stores the application specific settings
 * @return
 *      void
 */
void DLDShowPos::writeSettings ()
{
	settings->setValue ("pos", pos());
	settings->setValue ("size", size());
	settings->setValue ("showPersonInfo", showPersonInfoAct->isChecked ());
	settings->setValue ("showPersonInfoHint", showPersonInfoHintAct->isChecked ());
	settings->setValue ("showDatabaseListDock", showDatabaseListDockAct->isChecked ());
	settings->setValue ("zoomLevel", zoomSpin->value());
	log->infoLog ("Settings stored.");
}
/**
 * @brief slot: to show/hide the person info dock
 * @return
 *      void
 */
void DLDShowPos::showPersonInfo ()
{
	if (showPersonInfoAct->isChecked ())
		personInfoDock->show();
	else
		personInfoDock->hide();
}
/**
 * @brief slot: to show/hide the database list dock
 * @return
 *      void
 */
void DLDShowPos::showDatabaseListDock ()
{
	if (showDatabaseListDockAct->isChecked ())
		databaseListDock->show();
	else
		databaseListDock->hide();
}
/**
 * @brief slot: connect to the Generate position daemon
 * @return
 *      void
 */
void DLDShowPos::connectToGenPos ()
{
	Ui::selectConnectionDialog	selectConnectionUi;
	QDialog *       selectConnectionDialog = new QDialog;
	selectConnectionUi.setupUi (selectConnectionDialog);

	if (selectConnectionDialog->exec () != QDialog::Accepted)
		return ;

	if (selectConnectionUi.dBusRadio->isChecked ())     connectToDbus();

	connect (exchangeClient, SIGNAL(newPosition (int)), this, SLOT(updatePosition (int)));
	connect (exchangeClient, SIGNAL(newNode (int)), this, SLOT(newNode (int)));
	connect (exchangeClient, SIGNAL(newMaximumAxisValue (double)), mapScene, SLOT(setMaximumAxisValue (double)));
	mapScene->setMaximumAxisValue (exchangeClient->getMaximumAxisValue ());
	statusBar ()->showMessage (tr("Connected"));
	emit connectedToGenPos (true);
}
/**
 * @brief slot: disconnect from the generate position daemon
 * @return
 *      void
 */
void DLDShowPos::disconnectFromGenPos ()
{
	if (currentConnectionType == CONN_DBUS)
		log->debugLog ("TODO: disconnect From DBUS");
	else
		statusBar ()->showMessage (tr("not connected"));
	emit connectedToGenPos (false);
}
/**
 * @brief connect through D-Bus
 * @return
 *      void
 */
void DLDShowPos::connectToDbus ()
{
	currentConnectionType = CONN_DBUS;
	exchangeClient->addExchangeMethod (DLDDataExchangeClient::TYPE_DBUS, "org.dld.genPos", "", "dld.provide.position");
}

/**
 * @brief slot: this method is called when the exchange client got a new position.
 * @param tagId	id of the tag
 * @return
 *      void
 */
void DLDShowPos::updatePosition (int tagId)
{
	QDateTime time;
	TagPositionInformation info = exchangeClient->getPosition (tagId);
	updatePosition (tagId, info.x, info.y);
	tags[tagId].lastSeen = info.timestamp;

	time.setTime_t (info.timestamp);
	personInfoUi.lastSeenEdit->setText (time.toString("hh:mm:ss ap"));
}
/**
 * @brief updates the position of a tag
 * @param tagId	id of the tag
 * @param x	x position of the tag
 * @param y	y position of the tag
 * @return
 *      void
 */
void DLDShowPos::updatePosition (int tagId, double x, double y)
{
	// add the items to the scenen BUT only if they not already exist
	if (tags.contains (tagId))
	{
		tags[tagId].position = QPointF (x, y);
	} else // add it as a new one
	{
		TagViewInfo info;
		info.name = "Unnamed";
		info.prename = "Unnamed";
		info.color = QColor (Qt::white);
		info.description = "";
		info.position = QPointF (x, y);
		tags.insert (tagId, info);

		emit newDataNeeded (tagId);
	}
	addTagItem (tagId);
	// because of the view rotation the X and Y coordinations are swapped
	mapScene->setItemPosition (tagId, QPointF(tags[tagId].position.y(), tags[tagId].position.x()));
}
/**
 * @brief add the tag to the scene (initial)
 * @param tagId		id of the tag
 * @return
 *      void
 */
void DLDShowPos::addTagItem (int tagId)
{
	if (mapScene->isTagOnScene (tagId))
		return ;
	mapScene->addTagToScene (tagId);
	TagViewInfo info = tags[tagId];

	mapScene->addTagItem (tagId, info.color);
	// because of the view rotation the X and Y coordinations are swapped
	mapScene->setItemPosition (tagId, QPointF(info.position.y(), info.position.x()));
}
/**
 * @brief slot: loads a map file
 * @return
 *      void
 */
void DLDShowPos::loadMap ()
{
#warning loadMap is disabled
	log->debugLog ("Load map is not yet fully implemented.");
	return ; // do nothing until tha maps are implemented

	QString lastOpenMapPath = settings->value("lastOpenMapPath", "/home").toString ();
	QString path = QFileDialog::getOpenFileName(this, tr("Open Map"), lastOpenMapPath, tr("Images (*.mpk)"));
// check if cancel or OK
	settings->setValue ("lastOpenMapPath", path);
	// TODO: split the path into dir and fileName, the base of the filename is the mapName so make mapScene-setMapName (fileName
	// then the path can be used for loadMap
	if (!mapScene->loadMap (path))
	{
		QMessageBox::critical(this, tr("Loading failed"), tr("Map loading failed."));
		return ;
	}
}
/**
 * @brief slot: zooms the view
 * @param zoomBy	zoom by this value
 * @return
 *      void
 */
void DLDShowPos::zoom (double zoomBy)
{
	QMatrix matrix;
	matrix.scale(zoomBy, zoomBy);
	mapView->setMatrix(matrix);
	mapView->rotate (-90);
}
/**
 * @brief slot: called when the mouse hovers a tag item
 * @param tagId	the id of the tag that is hovered
 * @param x	x position of the mouse (in screen coordinations)
 * @param y	y position of the mouse (in screen coordinations)
 * @return
 *      void
 */
void DLDShowPos::mouseEnterTag (int tagId, int x, int y)
{
	if (tags.contains (tagId))
	{
		fillPersonInfoDock (tagId, tags[tagId]);
		if (showPersonInfoHintAct->isChecked ())
		{
			tagInfoDialog->setInformation (tagId, tags[tagId]);
			tagInfoDialog->move (x+tagInfoDialog->getXShift (), y);
			tagInfoDialog->show ();
		}
	}
}
/**
 * @brief slot: called when the mouse leaves the tag item
 * @return
 *      void
 */
void DLDShowPos::mouseLeaveTag ()
{
	tagInfoDialog->hide ();
}
/**
 * @brief slot: called when the mouse moves over a tag item
 * @param tagId	the id of the tag that is hovered
 * @param x	x position of the mouse (in screen coordinations)
 * @param y	y position of the mouse (in screen coordinations)
 * @return
 *      void
 */
void DLDShowPos::mouseMoveOverTag (int tagId, int x, int y)
{
	tagInfoDialog->move (x+tagInfoDialog->getXShift (), y);
}
/**
 * @brief sets the information of the dock
 * @param tagId	id of the tag
 * @param info	the informations of the tag
 * @return
 *      void
 */
void DLDShowPos::fillPersonInfoDock (int tagId, TagViewInfo info)
{
	QDateTime time;
	time.setTime_t (info.lastSeen);

	personInfoUi.nameEdit->setText (info.name);
	personInfoUi.prenameEdit->setText (info.prename);
	personInfoUi.lastSeenEdit->setText (time.toString("hh:mm:ss ap"));
	personInfoUi.tagIdEdit->setText (QString ("%1").arg(tagId));
	personInfoUi.colorEdit->setText (info.color.name ());
	personInfoUi.pictureLabel->setPixmap (info.image);
	personInfoUi.descriptionEdit->setText (info.description);
}
/**
 * @brief slot: adds a new node to the screen
 * @param nodeId	id of the node
 * @return
 *      void
 */
void DLDShowPos::newNode (int nodeId)
{
	ThreeDPoint point = exchangeClient->getNodeInformation (nodeId);
	addNodeInfo (nodeId, QPointF (point.x, point.y));
}
/**
 * @brief Opens the connect to database dialog and fills it with previously used values (except pass)
 * @return
 *      void
 */
void DLDShowPos::connectDialog ()
{
	QDialog *	connect2DBDialog = new QDialog;
	connect2DBDialogUi.setupUi (connect2DBDialog);

	connect2DBDialogUi.databaseTypeCombo->addItems (QSqlDatabase::drivers ());

	connect2DBDialogUi.databaseHost->setText (settings->value ("databaseHost", "").toString ());
	connect2DBDialogUi.databasePort->setValue (settings->value ("databasePort", "").toInt ());
	connect2DBDialogUi.databaseName->setText (settings->value ("databaseName", "").toString ());
	connect2DBDialogUi.databaseTable->setText (settings->value ("databaseTable", "persons").toString ());
	connect2DBDialogUi.databaseUsername->setText (settings->value ("databaseUsername", "").toString ());
	connect2DBDialogUi.databasePassword->setText("");
	connect2DBDialogUi.databaseTypeCombo->setCurrentIndex (connect2DBDialogUi.databaseTypeCombo->findText (settings->value ("databaseType", "").toString ()));

	// set focus to the first empty field:
	if (connect2DBDialogUi.databaseTypeCombo->currentText ().isEmpty())
		; // do nothing because we have the focus on the first field anyway
	else if (connect2DBDialogUi.databaseHost->text ().isEmpty())
		connect2DBDialogUi.databaseHost->setFocus ();
	else if (connect2DBDialogUi.databasePort->value () == 0)
		connect2DBDialogUi.databasePort->setFocus ();
	else if (connect2DBDialogUi.databaseName->text ().isEmpty())
		connect2DBDialogUi.databaseName->setFocus ();
	else if (connect2DBDialogUi.databaseTable->text ().isEmpty())
		connect2DBDialogUi.databaseTable->setFocus ();
	else if (connect2DBDialogUi.databaseUsername->text ().isEmpty())
		connect2DBDialogUi.databaseUsername->setFocus ();
	else
		connect2DBDialogUi.databasePassword->setFocus ();

	if (connect2DBDialog->exec () == QDialog::Accepted)
	{
		personsTable = connect2DBDialogUi.databaseTable->text ();

		settings->setValue ("databaseHost", connect2DBDialogUi.databaseHost->text ());
		settings->setValue ("databasePort", connect2DBDialogUi.databasePort->value ());
		settings->setValue ("databaseName", connect2DBDialogUi.databaseName->text ());
		settings->setValue ("databaseTable", connect2DBDialogUi.databaseTable->text ());
		settings->setValue ("databaseUsername", connect2DBDialogUi.databaseUsername->text ());
		settings->setValue ("databaseType", connect2DBDialogUi.databaseTypeCombo->currentText ());

		// check if everything needed is filled:
		if (connect2DBDialogUi.databaseHost->text ().isEmpty()
				  || connect2DBDialogUi.databasePort->text ().isEmpty ()
				  || connect2DBDialogUi.databaseName->text ().isEmpty ()
				  || connect2DBDialogUi.databaseTypeCombo->currentText ().isEmpty ())
		{
			QMessageBox::critical (this, tr("Not all needed informations were filled in"), tr("Either host, port, database name or database type were not filled in."));
			return ;
		}
		if (!connectToDB (connect2DBDialogUi.databaseTypeCombo->currentText (), connect2DBDialogUi.databaseHost->text ()
			, connect2DBDialogUi.databasePort->value (), connect2DBDialogUi.databaseName->text ()
			, connect2DBDialogUi.databaseUsername->text (), connect2DBDialogUi.databasePassword->text ()))
		{
			QMessageBox::critical (this, tr("Connection failed"), tr("Connection to database failed."));
			statusBar ()->showMessage (tr("Connection failed"));
			return;
		}
		statusBar ()->showMessage (tr("Connected"));
	}
}
/**
 * @brief method which is used to connect with the database
 * @param type		Qt type of the database which it should connect to
 * @param host		the host address of the database
 * @param port		the port on which the database is answering
 * @param dbName	the database name
 * @param username	the username which is used to access the data from the database
 * @param password	the password the user is using
 * @return
 *      bool		true if connected, false if not
 */
bool DLDShowPos::connectToDB (QString type, QString host, int port, QString dbName, QString username, QString password)
{
	disconnectFromDB ();

	database = QSqlDatabase::addDatabase (type);
	database.setDatabaseName (dbName);
	database.setUserName (username);
	database.setPassword (password);
	database.setHostName (host);
	database.setPort (port);

	if (!database.isValid ())
	{
		log->errorLog (QString ("Could not create database object with the type %1").arg (type));
		emit connectedToDatabase (false);
		return (false);
	}
	if (!database.open ())
	{
		log->errorLog ("Could not open database");
		emit connectedToDatabase (false);
		return (false);
	}
	log->infoLog (QString ("Connected to database: %1").arg (dbName));
	refreshEntries ();
	emit connectedToDatabase (true);
	return (true);
}
/**
 * @brief slot: disconnect from database
 * @return
 *      void
 */
void DLDShowPos::disconnectFromDB ()
{
	if (database.isValid () && database.isOpen ())
		database.close ();
	while (databaseListDockUi.personTableWidget->rowCount () > 0)
		databaseListDockUi.personTableWidget->removeRow (0);
	emit connectedToDatabase (false);
}
/**
 * @brief slot: refreshes the entries through a new query from the database
 * @return
 *      void
 */
void DLDShowPos::refreshEntries ()
{
	if (personsTable.isEmpty())
		return;

	QSqlQuery query;
	query.prepare(QString ("SELECT * FROM %1 ;").arg (personsTable));
	query.exec();

	while (databaseListDockUi.personTableWidget->rowCount () > 0)
		databaseListDockUi.personTableWidget->removeRow (0);

	int tagIdFieldNo = query.record().indexOf("tagId");
	int nameFieldNo = query.record().indexOf("name");
	int prenameFieldNo = query.record().indexOf("prename");
	int colorFieldNo = query.record().indexOf("color");
	int pictureFieldNo = query.record().indexOf("picture");
	int descriptionFieldNo = query.record().indexOf("description");
	while (query.next())
	{
		QString	id = query.value (tagIdFieldNo).toString ();
		QString	name = query.value (nameFieldNo).toString();
		QString prename = query.value (prenameFieldNo).toString();
		QString color = query.value (colorFieldNo).toString();
		QString description = query.value (descriptionFieldNo).toString();

		log->infoLog (QString ("SQL Incoming: TagId: %1 Name: %2 Prename: %3 Picture: BLOB Description: %4")
				.arg (id)
				.arg (name)
				.arg (prename)
				.arg (description));
		QTableWidgetItem * tagIdItem = new QTableWidgetItem (id);
		QTableWidgetItem * nameItem = new QTableWidgetItem (name);
		QTableWidgetItem * prenameItem = new QTableWidgetItem (prename);
		QTableWidgetItem * colorItem = new QTableWidgetItem (color);

		QTableWidgetItem * pictureItem = new QTableWidgetItem ();

		QPixmap pixmap;
		pixmap.loadFromData (query.value(pictureFieldNo).toByteArray());
		pictureItem->setIcon (QIcon (pixmap));
		pictureMap[query.value(tagIdFieldNo).toInt()] = pixmap;

		QTableWidgetItem * descriptionItem = new QTableWidgetItem(query.value(descriptionFieldNo).toString());

		tagIdItem->setFlags (Qt::ItemIsSelectable);
		nameItem->setFlags (Qt::ItemIsSelectable);
		prenameItem->setFlags (Qt::ItemIsSelectable);
		colorItem->setFlags (Qt::ItemIsSelectable);
		pictureItem->setFlags (Qt::ItemIsSelectable);
		descriptionItem->setFlags (Qt::ItemIsSelectable);

		databaseListDockUi.personTableWidget->setSortingEnabled (false);
		databaseListDockUi.personTableWidget->insertRow(0);
		databaseListDockUi.personTableWidget->setItem(0, 0, tagIdItem);
		databaseListDockUi.personTableWidget->setItem(0, 1, nameItem);
		databaseListDockUi.personTableWidget->setItem(0, 2, prenameItem);
		databaseListDockUi.personTableWidget->setItem(0, 3, colorItem);
		databaseListDockUi.personTableWidget->setItem(0, 4, pictureItem);
		databaseListDockUi.personTableWidget->setItem(0, 5, descriptionItem);
		databaseListDockUi.personTableWidget->setSortingEnabled (true);

		// store the data in the tags map as well:
		int tagId = id.toInt ();
		TagViewInfo info = tags[tagId];
		info.name = name;
		info.image = pixmap;
		info.prename = prename;
		info.color = color;
		info.description = description;
		tags.insert (tagId, info);

		mapScene->updateTagColor (tagId, info.color);
	}
}
/**
 * @brief slot: get new data from database and update the local info
 * @return
 *      void
 */
void DLDShowPos::getNewData (int tagId)
{
	if (!database.isValid () || !database.isOpen () || !personsTable.isEmpty())
		return;

	QSqlQuery query;
	query.prepare(QString ("SELECT * FROM %1 WHERE tagId=:tagId;").arg (personsTable));
	query.bindValue(":tagId", tagId);
	query.exec();

	int tagIdFieldNo = query.record().indexOf("tagId");
	int nameFieldNo = query.record().indexOf("name");
	int prenameFieldNo = query.record().indexOf("prename");
	int colorFieldNo = query.record().indexOf("color");
	int pictureFieldNo = query.record().indexOf("picture");
	int descriptionFieldNo = query.record().indexOf("description");

	TagViewInfo info = tags[tagId];
	if (query.first ())
	{
		log->infoLog (QString ("SQL Incoming: TagId: %1 Name: %2 Prename: %3 Color: %4Picture: BLOB Description: %5")
				.arg(query.value(tagIdFieldNo).toInt())
				.arg(query.value(nameFieldNo).toString())
				.arg(query.value(prenameFieldNo).toString())
				.arg(query.value(colorFieldNo).toString())
				.arg(query.value(descriptionFieldNo).toString()));

		info.image.loadFromData (query.value(pictureFieldNo).toByteArray());
		info.name = query.value(nameFieldNo).toString();
		info.prename = query.value(prenameFieldNo).toString();
		info.description = query.value(descriptionFieldNo).toString();
		info.color = QColor (query.value(colorFieldNo).toString());
	}
	tags.insert (tagId, info);
}
/**
 * @brief add node infor (nodes are currently not supported by the show pos application)
 * @param nodeId	id of the node
 * @param position	position of the node
 * @return
 *      void
 */
void DLDShowPos::addNodeInfo (int nodeId, QPointF position)
{
	log->debugLog ("TODO: addNodeInfo");
}
/**
 * @brief event filter to prevent that a dock hides itself after a minimised showPos is coming back to the screen
 * @param object	the object that send the event
 * @param event		the event that occurs
 * @return
 *      bool
 */
bool DLDShowPos::eventFilter( QObject * object, QEvent * event )
{
	if (object == personInfoDock || object == databaseListDock)
	{
		if ( event->type() == QEvent::Close && object == personInfoDock)
		{
			showPersonInfoAct->blockSignals( true );
			showPersonInfoAct->setChecked( false );
			showPersonInfoAct->blockSignals( false );
			return true;
		}else if (event->type() == QEvent::Close && object == databaseListDock)
		{
			showDatabaseListDockAct->blockSignals( true );
			showDatabaseListDockAct->setChecked( false );
			showDatabaseListDockAct->blockSignals( false );
			return true;
		}
		return false;
	}

	return QMainWindow::eventFilter( object, event );
}
