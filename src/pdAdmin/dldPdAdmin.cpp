/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */

/** @class DLDPersonDataAdmin pdAdmin.h
 *
 * @author Simon Schaefer
 *
 * @date 16.03.2008
 *
 * @version 1.0
 * <br> Class for the person data administrator application
 */
#include "dldPdAdmin.h"

#include <common/dldLog.h>

#include <QSettings>
#include <QtSql>
#include <QtGui>

/**
 * @brief constructor for DLDPersonDataAdmin class
 * @param logLevel verboxity level for logging
 * @param logFile file for logging
 * @return
 *      void
 */
DLDPersonDataAdmin::DLDPersonDataAdmin (int logLevel, QString logFile)
{
	log = new DLDLog ();
	log->setLogLevel (logLevel);
	if (!logFile.isEmpty())
		log->setLogFile (logFile);

	settings = new QSettings ("DLD", "Person data administrator application");
	log->infoLog (QString ("Settings will be stored in: %1.").arg (settings->fileName ()));

	mainWindowUi.setupUi (this);

	// fill table header
	QStringList tableHeader;
	tableHeader << tr ("Tag ID") << tr ("Name") << tr ("Prename") << tr ("Color") << tr ("Picture") << tr ("Description");
	mainWindowUi.personTableWidget->setHorizontalHeaderLabels (tableHeader);

	createConnections ();
}
/**
 * @brief destructor for DLDPersonDataAdmin class
 * @return
 *      void
 */
DLDPersonDataAdmin::~DLDPersonDataAdmin ()
{
	if (log)
		delete (log);
	if (settings)
	{
		settings->sync ();
		delete (settings);
	}
	closeDatabase ();
}
/**
 * @brief creates the connections (from the buttons to the slots)
 * @return
 *      void
 */
void DLDPersonDataAdmin::createConnections ()
{
	connect (mainWindowUi.actionQuit,		SIGNAL (triggered ()), this, SLOT (close ()));
	connect (mainWindowUi.actionConnect,		SIGNAL (triggered ()), this, SLOT (connectDialog ()));
	connect (mainWindowUi.fileButton,		SIGNAL (pressed ()), this, SLOT (choosePicture ()));
	connect (mainWindowUi.colorButton,		SIGNAL (pressed ()), this, SLOT (chooseColor ()));
	connect (mainWindowUi.refreshButton,		SIGNAL (pressed ()), this, SLOT (refreshEntries ()));
	connect (mainWindowUi.deleteButton,		SIGNAL (pressed ()), this, SLOT (deleteEntry ()));
	connect (mainWindowUi.commitButton,		SIGNAL (pressed ()), this, SLOT (commitChanges ()));
	connect (mainWindowUi.clearButton,		SIGNAL (pressed ()), this, SLOT (clearFields ()));
	connect (mainWindowUi.personTableWidget,	SIGNAL (cellClicked (int, int)), this, SLOT (fillFields (int, int)));
}
/**
 * @brief Opens the connect to database dialog and fills it with previously used values (except pass)
 * @return
 *      void
 */
void DLDPersonDataAdmin::connectDialog ()
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
		databaseName = connect2DBDialogUi.databaseName->text ();

		settings->setValue ("databaseHost", connect2DBDialogUi.databaseHost->text ());
		settings->setValue ("databasePort", connect2DBDialogUi.databasePort->value ());
		settings->setValue ("databaseName", databaseName);
		settings->setValue ("databaseTable", personsTable);
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
		if (!connect2DB (connect2DBDialogUi.databaseTypeCombo->currentText (), connect2DBDialogUi.databaseHost->text ()
				, connect2DBDialogUi.databasePort->value (), connect2DBDialogUi.databaseName->text ()
				, connect2DBDialogUi.databaseUsername->text (), connect2DBDialogUi.databasePassword->text ()))
		{
			QMessageBox::critical (this, tr("Connection failed"), tr("Connection to DB failed."));
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
bool DLDPersonDataAdmin::connect2DB (QString type, QString host, int port, QString dbName, QString username, QString password)
{
	closeDatabase ();

	database = QSqlDatabase::addDatabase (type);
	database.setDatabaseName (dbName);
	database.setUserName (username);
	database.setPassword (password);
	database.setHostName (host);
	database.setPort (port);

	if (!database.isValid ())
	{
		log->errorLog (QString ("Could not create database object with the type %1").arg (type));
		return (false);
	}
	if (!database.open ())
	{
		log->errorLog ("Could not open database");
		return (false);
	}
	log->infoLog (QString ("Connected to DB %1").arg (dbName));
	mainWindowUi.databaseEdit->setText (dbName);
	refreshEntries ();
	return (true);
}
/**
 * @brief slot: closes the database
 * @return
 *      void
 */
void DLDPersonDataAdmin::closeDatabase ()
{
	if (database.isValid () && database.isOpen ())
		database.close ();
}
/**
 * @brief slot: opens a file dialog for image selection
 * @return
 *      void
 */
void DLDPersonDataAdmin::choosePicture ()
{
	QString lastPicturePath = settings->value("lastPicturePath", QDir::homePath()).toString ();
	QString imagePath = QFileDialog::getOpenFileName(0, tr("Choose an image"), lastPicturePath, tr("Images (*.png *.xpm *.jpg)"));
	settings->setValue ("lastPicturePath", imagePath);
	mainWindowUi.pictureLabel->setPixmap(QPixmap(imagePath));
}
/**
 * @brief slot: deletes an entry from list AND database
 * @return
 *      void
 */
void DLDPersonDataAdmin::deleteEntry ()
{
	int row = mainWindowUi.personTableWidget->currentRow ();
	if (row < 0) // no row selected
		return ;

	if (!database.isValid () || !database.isOpen ())
	{
		QMessageBox::critical (this, tr("Error"), tr("Database is not valid or not opened."));
		return ;
	}

	if (QMessageBox::question (this, tr("Delete"), tr ("Do you really want to delete this entry?"), QMessageBox::Yes | QMessageBox::No, QMessageBox::No) == QMessageBox::Yes)
	{
		// in column 0 is the tagId the key of the table
		int tagId =  mainWindowUi.personTableWidget->item (row, 0)->text ().toInt ();
		QSqlQuery query;
		query.prepare (QString ("DELETE FROM %1 WHERE %1.tagId = %2 LIMIT 1")
				.arg (personsTable)
				.arg (tagId));
		query.exec ();
		pictureMap.remove (tagId);
		clearFields ();
		refreshEntries ();
		log->infoLog (QString ("Entry with key %1 deleted.").arg (tagId));
	}
}
/**
 * @brief slot: commits the changes or creates a new entry
 * @return
 *      void
 */
void DLDPersonDataAdmin::commitChanges ()
{
	if (!database.isValid () || !database.isOpen ())
	{
		QMessageBox::critical (this, tr("Error"), tr("Database is not valid or not opened."));
		return ;
	}
	if (mainWindowUi.nameEdit->text().isEmpty() || mainWindowUi.preNameEdit->text().isEmpty() || mainWindowUi.tagIdSpin->value () == 0)
	{
		QMessageBox::critical (this, tr("Missing parameters"), tr("You need to fill in a name, prename and a valid tagId (>0)."));
		return ;
	}
	QSqlQuery query;
	query.prepare (QString ("INSERT INTO %1 ( `tagId` , `name` , `prename` , `color` , `picture` , `description` ) "
			" VALUES ( :tagId, :name, :prename, :color, :picture, :description );").arg (personsTable));
	query.bindValue(":tagId", mainWindowUi.tagIdSpin->value ());
	query.bindValue(":name", mainWindowUi.nameEdit->text());
	query.bindValue(":prename", mainWindowUi.preNameEdit->text());
	query.bindValue(":color", mainWindowUi.colorEdit->text());
	query.bindValue(":picture", savePixmapToByteArray (mainWindowUi.pictureLabel->pixmap ()));
	query.bindValue(":description", mainWindowUi.descriptionEdit->toPlainText ());
	query.exec ();

	if (query.lastError ().number () == DB_ENTRY_ALREADY_EXISTS)
	{
		if (QMessageBox::question (this, tr("Change"), tr ("Do you really want to change this entry?"), QMessageBox::Yes | QMessageBox::No, QMessageBox::No) == QMessageBox::Yes)
		{
			query.prepare (QString ("UPDATE %1 SET name = :name, prename = :prename, color = :color, picture = :picture"
					", description = :description WHERE tagId = :tagId ;").arg (personsTable));
			query.bindValue(":tagId", mainWindowUi.tagIdSpin->value ());
			query.bindValue(":name", mainWindowUi.nameEdit->text());
			query.bindValue(":prename", mainWindowUi.preNameEdit->text());
			query.bindValue(":color", mainWindowUi.colorEdit->text());
			query.bindValue(":picture", savePixmapToByteArray (mainWindowUi.pictureLabel->pixmap ()));
			query.bindValue(":description", mainWindowUi.descriptionEdit->toPlainText ());
			query.exec ();
		}
	}
	if (query.lastError ().type () != QSqlError::NoError)
	{
		QMessageBox::critical (this, tr ("Error"), query.lastError ().databaseText ());
		log->errorLog (query.lastError ().databaseText());
	}
	clearFields ();
	refreshEntries ();
}
/**
 * @brief slot: refreshes the entries through a new query from the database
 * @return
 *      void
 */
void DLDPersonDataAdmin::refreshEntries ()
{
	if (personsTable.isEmpty())
		return;

	QSqlQuery query;
	query.prepare(QString ("SELECT * FROM %1 ;").arg (personsTable));
	query.exec();

	while (mainWindowUi.personTableWidget->rowCount () > 0)
		mainWindowUi.personTableWidget->removeRow (0);

	int tagIdFieldNo = query.record().indexOf("tagId");
	int nameFieldNo = query.record().indexOf("name");
	int prenameFieldNo = query.record().indexOf("prename");
	int colorFieldNo = query.record().indexOf("color");
	int pictureFieldNo = query.record().indexOf("picture");
	int descriptionFieldNo = query.record().indexOf("description");
	while (query.next())
	{
		log->infoLog (QString ("SQL Incoming: TagId: %1 Name: %2 Prename: %3 Color: %4Picture: BLOB Description: %5")
				.arg(query.value(tagIdFieldNo).toInt())
				.arg(query.value(nameFieldNo).toString())
				.arg(query.value(prenameFieldNo).toString())
				.arg(query.value(colorFieldNo).toString())
				.arg(query.value(descriptionFieldNo).toString()));
		QTableWidgetItem * tagIdItem = new QTableWidgetItem(query.value(tagIdFieldNo).toString());
		QTableWidgetItem * nameItem = new QTableWidgetItem(query.value(nameFieldNo).toString());
		QTableWidgetItem * prenameItem = new QTableWidgetItem(query.value(prenameFieldNo).toString());
		QTableWidgetItem * colorItem = new QTableWidgetItem(query.value(colorFieldNo).toString());

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

		mainWindowUi.personTableWidget->setSortingEnabled (false);
		mainWindowUi.personTableWidget->insertRow(0);
		mainWindowUi.personTableWidget->setItem(0, 0, tagIdItem);
		mainWindowUi.personTableWidget->setItem(0, 1, nameItem);
		mainWindowUi.personTableWidget->setItem(0, 2, prenameItem);
		mainWindowUi.personTableWidget->setItem(0, 3, colorItem);
		mainWindowUi.personTableWidget->setItem(0, 4, pictureItem);
		mainWindowUi.personTableWidget->setItem(0, 5, descriptionItem);
		mainWindowUi.personTableWidget->setSortingEnabled (true);
	}
}
/**
 * @brief slot: cleans the fields that are used to create/change entries
 * @return
 *      void
 */
void DLDPersonDataAdmin::clearFields ()
{
	log->debugLog ("wiping out the fields...");
	mainWindowUi.tagIdSpin->setValue (0);
	mainWindowUi.nameEdit->setText ("");
	mainWindowUi.preNameEdit->setText ("");
	mainWindowUi.colorEdit->setText ("");
	mainWindowUi.descriptionEdit->setText ("");
	mainWindowUi.pictureLabel->setPixmap(NULL);
	mainWindowUi.pictureLabel->setText ("no pic");
	log->debugLog ("wipe out done.");
}
/**
 * @brief slot: fills the entry fields with the data from the
 * @param row		the row which was selected
 * @param column	unused, but needed so the signal could be connected with the coresponding slot
 * @return
 *      void
 */
void DLDPersonDataAdmin::fillFields (int row, int)
{
	int tagId = mainWindowUi.personTableWidget->item (row, 0)->text().toInt();
	mainWindowUi.tagIdSpin->setValue (tagId);
	mainWindowUi.nameEdit->setText (mainWindowUi.personTableWidget->item (row, 1)->text());
	mainWindowUi.preNameEdit->setText (mainWindowUi.personTableWidget->item (row, 2)->text());
	mainWindowUi.colorEdit->setText (mainWindowUi.personTableWidget->item (row, 3)->text());

	QPixmap colorMap (QSize (21,21));
	colorMap.fill (QColor (mainWindowUi.colorEdit->text ()));
	mainWindowUi.colorLabel->setPixmap (colorMap);

	mainWindowUi.pictureLabel->setPixmap (pictureMap[tagId]);
	mainWindowUi.descriptionEdit->setText (mainWindowUi.personTableWidget->item (row, 5)->text());
}
/**
 * @brief slot: opens the std color dialog and lets the user choose one
 * @return
 *      void
 */
void DLDPersonDataAdmin::chooseColor ()
{
	QColor color = QColorDialog::getColor (mainWindowUi.colorEdit->text(), this);
	if (color.isValid ())
	{
		QPixmap colorMap (QSize (21,21));
		colorMap.fill (color);
		mainWindowUi.colorLabel->setPixmap (colorMap);
		mainWindowUi.colorEdit->setText (color.name ());
	}
}
/**
 * @brief converts the pixmap to a byteArray similar to a file read out
 * @param pixmap the pixmap to convert
 * @return
 *      QByteArray	the pixmaps byteArray
 */
QByteArray DLDPersonDataAdmin::savePixmapToByteArray (const QPixmap * pixmap)
{
	QByteArray	bytes;
	QBuffer		buffer(&bytes);

	buffer.open(QIODevice::WriteOnly);
	pixmap->save(&buffer, "PNG");
	buffer.close();
	return (bytes);
}
