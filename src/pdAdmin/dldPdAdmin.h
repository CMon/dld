/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */
#pragma once

#include <QMainWindow>
#include <QMap>
#include <QPixmap>
#include <QFile>
#include <QSqlDatabase>

#include "ui_mainWindow.h"
#include "ui_connect2DBDialog.h"

class QSettings;
class DLDLog;

class DLDPersonDataAdmin : public QMainWindow
{
	Q_OBJECT
	public:
		DLDPersonDataAdmin (int logLevel, QString logFile);
		~DLDPersonDataAdmin ();

	private slots:
		void connectDialog ();
		void choosePicture ();
		void deleteEntry ();
		void commitChanges ();
		void refreshEntries ();
		void clearFields ();
		void fillFields (int row, int);
		void chooseColor ();

	private:
		// the error number that is thrown in those cases:
		static const int	DB_ENTRY_ALREADY_EXISTS	= 1062;

		void		createConnections ();

		bool		connect2DB (QString type, QString host, int port, QString dbName, QString username, QString password);
		void		closeDatabase ();
		QByteArray	savePixmapToByteArray (const QPixmap * pixmap);
		QString		addPerson (QString sqlString);
		QString		deletePerson (QString keyValue);
		QString		changePerson (QString sqlString);

		Ui::mainWindow		mainWindowUi;
		Ui::connect2DBDialog	connect2DBDialogUi;

		QSettings *		settings;
		DLDLog *		log;
		QSqlDatabase		database;
		QString			databaseName;
		QString			personsTable;

		QMap <int, QPixmap>	pictureMap;
};
