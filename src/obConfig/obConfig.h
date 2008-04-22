 /*
  * obConfig.h  - domestic location detection - OpenBeacon Configurator
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
#ifndef __OBCONFIG_H
#define __OBCONFIG_H

// QT includes
#include <QMainWindow>

// Project includes
#include "../common/obCommunication.h"

// ui includes:
#include "ui_preferences.h"
#include "ui_mainWindow.h"
#include "ui_aboutOpenBeacon.h"

#include <QSettings>
#include <QProcess>

class QString;
class QTimer;
class QTemporaryFile;
class DLDLog;

class DLDConfigureOB : public QMainWindow
{
Q_OBJECT

public:
	DLDConfigureOB (int logLevel);
	~DLDConfigureOB ();

signals:
	void			deviceSelected (bool flashGroup, bool configureGroup);
	void			commandListChanged ();
	void			devicepathsChanged ();
	void			logFileChanged (QString);

private slots:
	void			endisableGroupBox (bool flashGroup, bool configureGroup);
	void			showPreferences ();
	void			insertCommandTableRow ();
	void			deleteCommandTableRow ();
	void			refillCommandList ();
	void			commandHighlighted (int index);
	void			updateCommandBoxStatusTip (int index);
	void			selectFlashImage ();
	void			refreshDevices ();
	void			updateGroupBoxVisibility (int index);
	void			showHelp ();
	void			selectLogFile ();
	void			changeLogFile (QString logFilePath);
	void			executeCommand ();
	void			openNewDevice (int index);
	void			receivedNewData (QString answer);
	void			writeFailed ();
	void			clearConsole ();
	void			flashDevice ();
	void			selectSam7File ();
	void			addCharToConsole ();
	void			printProcessError (QProcess::ProcessError error);
	void			processFinished (int exitCode, QProcess::ExitStatus exitStatus);
	void			aboutOpenBeacon ();
	void			fillDefaultCommands ();
	void			checkFilled ();

private:
	// Methods
	void			addCommandTableRow (int row, QString firstCell, QString secondCell);
	bool			flashDevice (QString deviceName);
	bool			configureDevice (QString command);
	void			connectSignals ();
	QMap<QString, QString>	getCommandMap ();
	void			writeCommandMap (QMap<QString, QString> commandMap);

	// Attributes
	OpenBeaconCommunication *	device;
	DLDLog *			log;
	QSettings *			settings;
	QTimer *			refreshTimer;
	bool				showRX;
	QProcess *			batchProcess;

	// user interfaces
	Ui::preferncesDialog		preferences;
	Ui::mainWindow			mainWindow;
};

#endif
