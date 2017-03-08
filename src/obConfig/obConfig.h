/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */
#pragma once

#include <common/obCommunication.h>

#include <QMainWindow>
#include <QSettings>
#include <QProcess>

#include "ui_preferences.h"
#include "ui_mainWindow.h"
#include "ui_aboutOpenBeacon.h"

class QString;
class QTimer;
class QTemporaryFile;

class DLDConfigureOB : public QMainWindow
{
Q_OBJECT

public:
	DLDConfigureOB ();
	~DLDConfigureOB ();

signals:
	void			deviceSelected (bool flashGroup, bool configureGroup);
	void			commandListChanged ();
	void			devicepathsChanged ();

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
	QSettings *			settings;
	QTimer *			refreshTimer;
	bool				showRX;
	QProcess *			batchProcess;

	// user interfaces
	Ui::preferncesDialog		preferences;
	Ui::mainWindow			mainWindow;
};
