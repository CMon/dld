 /*
  * obConfig.cpp  - domestic location detection - OpenBeacon Configurator
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
/** @class OpenBeaconConfigurator obConfig.h
 *
 * @author Simon Schaefer
 *
 * @date 09.02.2008
 *
 * @version 1.0
 * <br> Class for the OpenBeacon Configurator Application
 */

// Qt includes:
#include <QMainWindow>
#include <QString>
#include <QSettings>
#include <QMap>
#include <QHeaderView>
#include <QMessageBox>
#include <QFileDialog>
#include <QDir>
#include <QTimer>
#include <QTime>
#include <QProcess>
#include <QTextStream>
#include <QTemporaryFile>

#include "ui_obConfiguratorHelp.h"
#include "ui_replaceCommandsDialog.h"

#include "obConfig.h"
#include "../common/dldLog.h"

/**
 * @brief constructor for OpenBeacon Configurator
 * @param logLevel the logLevel which should be used for the application
 * @return
 *      void
 */
DLDConfigureOB::DLDConfigureOB (int logLevel)
{
// settings
	settings = new QSettings ("DLD", "OpenBeacon Configurator");
	int xPos = settings->value("xPos", 10).toInt ();
	int yPos = settings->value("yPos", 10).toInt ();
	int windowWidth = settings->value("windowWidth", 465).toInt ();
	int windowHeight = settings->value("windowHeight", 531).toInt ();
	showRX = settings->value("showRX", false).toBool ();

// set logging
	QString logFile = settings->value("logFile", "").toString ();
	log = new DLDLog();
	log->setLogLevel (logLevel);
	if (!logFile.isEmpty())
	{
		log->setLogType (DLDLog::LOG_TO_FILE);
		log->setLogFile (logFile);
		log->infoLog ("logging to file.");
	} else
		log->infoLog ("logging to console.");

// device
	device = new OpenBeaconCommunication (log);

// ui
	mainWindow.setupUi (this);
	setGeometry (xPos, yPos, windowWidth, windowHeight);

	endisableGroupBox (false, false);
	refreshTimer = new QTimer (this);
	refreshTimer->start (settings->value("DeviceRefreshRate", 5).toInt () * 1000);

// flashing
	batchProcess = new QProcess (this);
	batchProcess->setReadChannel (QProcess::StandardOutput);

	connectSignals ();

	refillCommandList ();
	refreshDevices ();
}
/**
 * @brief destructor for OpenBeacon Configurator
 * @return
 *      void
 */
DLDConfigureOB::~DLDConfigureOB ()
{
	settings->setValue("xPos", x());
	settings->setValue("yPos", y());
	settings->setValue("windowWidth", width ());
	settings->setValue("windowHeight", height ());
	settings->setValue("showRX", showRX);

	delete (settings);

	batchProcess->waitForFinished (300000); // wait up to 5min to finish flashing
	delete (batchProcess);
	delete (device);
	delete (log);
}
/**
 * @brief connect all buttons of the ui
 * @return
 *      void
 */
void DLDConfigureOB::connectSignals ()
{
	// connect menu actions
	connect(mainWindow.actionQuit,		SIGNAL(triggered ()), this, SLOT(close ()));
	connect(mainWindow.actionRefresh,	SIGNAL(triggered ()), this, SLOT(refreshDevices ()));
	connect(mainWindow.actionPreferences,	SIGNAL(triggered ()), this, SLOT(showPreferences ()));
	connect(mainWindow.actionOpenBeaconConfiguratorHelp, SIGNAL(triggered ()), this, SLOT(showHelp()));
	connect(mainWindow.actionAboutQt,	SIGNAL(triggered ()), qApp, SLOT(aboutQt ()));
	connect(mainWindow.actionAboutOpenBeacon,SIGNAL(triggered ()), this, SLOT(aboutOpenBeacon ()));

	// connect main Window buttons with methods
	connect(mainWindow.selectFileButton,	SIGNAL(clicked ()), this, SLOT(selectFlashImage ()));
	connect(mainWindow.flashButton,		SIGNAL(clicked ()), this, SLOT(flashDevice ()));
	connect(mainWindow.refreshButton,	SIGNAL(clicked ()), this, SLOT(refreshDevices ()));
	connect(mainWindow.executeButton,	SIGNAL(clicked ()), this, SLOT(executeCommand ()));
	connect(mainWindow.clearButton,		SIGNAL(clicked ()), this, SLOT(clearConsole ()));

	// connect box signals
	connect(mainWindow.commandCombo,	SIGNAL(highlighted (int)), this, SLOT(commandHighlighted (int)));
	connect(mainWindow.commandCombo,	SIGNAL(currentIndexChanged (int)), this, SLOT(updateCommandBoxStatusTip (int)));
	connect(mainWindow.deviceCombo,		SIGNAL(currentIndexChanged (int)), this, SLOT(updateGroupBoxVisibility (int)));
	connect(mainWindow.deviceCombo,		SIGNAL(activated (int)), this, SLOT(openNewDevice (int)));

	// connect device
	connect(device,				SIGNAL(newData (QString)), this, SLOT(receivedNewData (QString)));
	connect(device,				SIGNAL(writeFailed ()), this, SLOT(writeFailed ()));

	// connect internal signals
	connect(this,		SIGNAL(deviceSelected (bool, bool)),	this, SLOT(endisableGroupBox (bool, bool)));
	connect(this,		SIGNAL(commandListChanged ()),		this, SLOT(refillCommandList ()));
	connect(this,		SIGNAL(devicepathsChanged ()),		this, SLOT(refreshDevices ()));
	connect(refreshTimer,	SIGNAL(timeout()),			this, SLOT(refreshDevices ()));
	connect(this,		SIGNAL(logFileChanged (QString)),	this, SLOT(changeLogFile (QString)));
	connect(batchProcess,	SIGNAL(readyReadStandardOutput ()),	this, SLOT(addCharToConsole ()));
	connect(batchProcess,	SIGNAL(error (QProcess::ProcessError)),	this, SLOT(printProcessError (QProcess::ProcessError)));
	connect(batchProcess,	SIGNAL(finished (int, QProcess::ExitStatus)),this, SLOT(processFinished (int, QProcess::ExitStatus)));
}
/**
 * @brief slot: enable or disable the flash/configure Groupboxes
 * @return
 *      void
 */
void DLDConfigureOB::endisableGroupBox (bool flashGroup, bool configureGroup)
{
	mainWindow.flashGroup->setEnabled (flashGroup);
	mainWindow.configureGroup->setEnabled (configureGroup);
}
/**
 * @brief slot: show preference dialog
 * @return
 *      void
 */
void DLDConfigureOB::showPreferences ()
{
	QDialog * preferenceDialog = new QDialog;
	preferences.setupUi (preferenceDialog);

	// fill with defaults: (from settings)
	QString logFile = settings->value("logFile", "").toString ();
	preferences.flashBasepathEdit->setText (settings->value("FlashBasepath", "ttyUSB").toString ());
	preferences.openBeaconBasepathEdit->setText (settings->value("OpenBeaconBasepath", "ttyACM").toString ());
	preferences.refreshSpin->setValue (settings->value("DeviceRefreshRate", 5).toInt ());
	preferences.logFileEdit->setText (logFile);
	preferences.sam7PathEdit->setText (settings->value("sam7Path", "/usr/local/bin/sam7").toString ());
	preferences.showTagPacketsCheck->setChecked (showRX);

	// fill command table
	QStringList		tableHeader;
	tableHeader << tr ("Command") << tr ("Command description");
	preferences.commandTable->setColumnCount(2);
	preferences.commandTable->setHorizontalHeaderLabels (tableHeader);
	preferences.commandTable->horizontalHeader()->setResizeMode(QHeaderView::ResizeToContents);
	preferences.commandTable->setShowGrid(true);

	QMap<QString, QString> cmdMap = getCommandMap ();
	QMapIterator<QString, QString> i (cmdMap);
	while (i.hasNext())
	{
		i.next();
		QTableWidgetItem * cmdNameItem = new QTableWidgetItem(i.key());
		QTableWidgetItem * cmdDescItem = new QTableWidgetItem(i.value());
		preferences.commandTable->insertRow(0);
		preferences.commandTable->setItem(0, 0, cmdNameItem);
		preferences.commandTable->setItem(0, 1, cmdDescItem);
	}

	// connect buttons:
	connect(preferences.addButton,		SIGNAL(clicked ()), this, SLOT(insertCommandTableRow ()));
	connect(preferences.deleteButton,	SIGNAL(clicked ()), this, SLOT(deleteCommandTableRow ()));
	connect(preferences.logFileButton,	SIGNAL(clicked ()), this, SLOT(selectLogFile ()));
	connect(preferences.sam7PathButton,	SIGNAL(clicked ()), this, SLOT(selectSam7File ()));
	connect(preferences.defaultCommandsButton,SIGNAL(clicked ()), this, SLOT(fillDefaultCommands ()));

	// connect entry checks
	connect(preferences.flashBasepathEdit,	SIGNAL(editingFinished ()), this, SLOT(checkFilled ()));
	connect(preferences.openBeaconBasepathEdit,SIGNAL(editingFinished ()), this, SLOT(checkFilled ()));

	if (preferenceDialog->exec () == QDialog::Accepted)
	{
		int refreshRate = preferences.refreshSpin->value ();
		settings->setValue("FlashBasepath", preferences.flashBasepathEdit->text ());
		settings->setValue("OpenBeaconBasepath", preferences.openBeaconBasepathEdit->text ());
		settings->setValue("DeviceRefreshRate", refreshRate);
		settings->setValue("showRX", showRX);
		showRX = preferences.showTagPacketsCheck->isChecked();
		settings->setValue("sam7Path", preferences.sam7PathEdit->text ());

		QString newLogFile = preferences.logFileEdit->text();
		if (logFile != newLogFile)
		{
			emit logFileChanged (newLogFile);
			settings->setValue("logFile", newLogFile);
			log->infoLog (QString("Logpath changed to: %1").arg(newLogFile));
		}

		QMap<QString, QString> newCmdMap;
		log->debugLog ("Current command list:");
		for (int row = 0; row < preferences.commandTable->rowCount(); row++)
		{
			QTableWidgetItem *cmdNameItem = preferences.commandTable->item(row, 0);
			QTableWidgetItem *cmdDescItem = preferences.commandTable->item(row, 1);
			if (cmdNameItem && cmdDescItem)
			{
				newCmdMap.insert (cmdNameItem->text(), cmdDescItem->text());
				log->debugLog (QString ("Name: %1\tDesc: %2").arg(cmdNameItem->text()).arg(cmdDescItem->text()));
			}
		}
		writeCommandMap (newCmdMap);
		refreshDevices ();
		refreshTimer->setInterval (refreshRate * 1000);
	}
}
/**
 * @brief slot: adds a new row to the command table in preferences dialog
 * @return
 *      void
 */
void DLDConfigureOB::insertCommandTableRow ()
{
	preferences.commandTable->insertRow(0);
}
/**
 * @brief slot: removes the current selected row from command table (in preferences dialog)
 * @return
 *      void
 */
void DLDConfigureOB::deleteCommandTableRow ()
{
	int currentRow = preferences.commandTable->currentRow ();
	if (currentRow < 0)
		return;
	if (QMessageBox::question (this, tr("Delete command"), tr("Are you sure you want to delete the selected command?"), QMessageBox::Yes, QMessageBox::No) == QMessageBox::No)
		return;
	log->debugLog (QString ("Row %1 deleted.").arg (currentRow));
	preferences.commandTable->removeRow (currentRow);
}
/**
 * @brief reads the commands that are available form the stored settings
 * @return
 *      QMap<QString, QString> the map that is returned
 */
QMap<QString, QString> DLDConfigureOB::getCommandMap ()
{
	int nCmds = settings->value("numberOfCommands", 0).toInt ();
	QMap<QString, QString> cmdMap;
	if (nCmds <= 0)
		return cmdMap;
	QString nameBase = "%1-commandName";
	QString descBase = "%1-commandDescription";
	for (int i = 0; i < nCmds; i++)
	{
		cmdMap.insert (settings->value(nameBase.arg(i), "").toString (),
				settings->value(descBase.arg(i), "").toString ());
	}
	return (cmdMap);
}
/**
 * @brief reads the commands that are available form the stored settings
 * @param commandMap the map that is to store
 * @return
 *	void
 */
void DLDConfigureOB::writeCommandMap (QMap<QString, QString> commandMap)
{
	QMapIterator<QString, QString> iter (commandMap);
	int i;
	QString nameBase = "%1-commandName";
	QString descBase = "%1-commandDescription";
	for (i = 0; iter.hasNext (); i++)
	{
		iter.next();
		settings->setValue(nameBase.arg(i), iter.key());
		settings->setValue(descBase.arg(i), iter.value());
	}
	settings->setValue("numberOfCommands", i);
	emit commandListChanged ();
}
/**
 * @brief slot: refills the command list in the main window
 * @return
 *	void
 */
void DLDConfigureOB::refillCommandList ()
{
	int nCmds = settings->value("numberOfCommands", 0).toInt ();
	mainWindow.commandCombo->clear ();
	if (nCmds <= 0)
		return;
	QString nameBase = "%1-commandName";
	QString descBase = "%1-commandDescription";
	for (int i = 0; i < nCmds; i++)
	{
		mainWindow.commandCombo->insertItem (0, settings->value(nameBase.arg(i), "").toString ()
				, settings->value(descBase.arg(i), "").toString ());
	}
	mainWindow.commandCombo->setCurrentIndex (0);
}
/**
 * @brief slot: a command from the combobox is highlighted
 * @param index	the index of highlighted item
 * @return
 *	void
 */
void DLDConfigureOB::commandHighlighted (int index)
{
	mainWindow.statusbar->showMessage (mainWindow.commandCombo->itemData (index).toString());
}
/**
 * @brief slot: a command from the combobox is highlighted
 * @param index	the index of selected item
 * @return
 *	void
 */
void DLDConfigureOB::updateCommandBoxStatusTip (int index)
{
	mainWindow.commandCombo->setStatusTip (mainWindow.commandCombo->itemData (index).toString());
	mainWindow.valueEdit->setText ("");
}
/**
 * @brief slot: opens a file dialog and fills the appropiate textbox with the selection
 * @return
 *	void
 */
void DLDConfigureOB::selectFlashImage ()
{
	QString lastImagePath = settings->value("lastFlashImagePath", QDir::homePath()).toString ();
	QString filepath = QFileDialog::getOpenFileName(0, tr ("Choose an image to flash"), lastImagePath, "binary (*.bin)");
	log->debugLog (QString("Filepath selected: %1").arg(filepath));
	mainWindow.imagepathEdit->setText (filepath);
	if (!filepath.isEmpty())
	{
		settings->setValue("lastFlashImagePath", filepath);
		log->debugLog (QString("lastFlashImagePath changed: %1").arg(filepath));
	}
}
/**
 * @brief slot: refreshes the device list
 * @return
 *	void
 */
void DLDConfigureOB::refreshDevices ()
{
	// save focus (see below)
	QWidget * focusedWidget = focusWidget ();

	QString flPath = settings->value("FlashBasepath", "ttyUSB").toString ().append ("*");
	QString obPath = settings->value("OpenBeaconBasepath", "ttyACM").toString ().append ("*");
	QStringList filter;
	filter << flPath << obPath;

	QDir dir("/dev/");
	QString currentSelection = mainWindow.deviceCombo->currentText ();
	mainWindow.deviceCombo->clear ();
	mainWindow.deviceCombo->addItems (dir.entryList(filter, QDir::System));
	mainWindow.deviceCombo->insertItem (0, "", ""); // the first entry should be empty
	if (currentSelection.isEmpty())
		mainWindow.deviceCombo->setCurrentIndex (0);
	else
		mainWindow.deviceCombo->setCurrentIndex (mainWindow.deviceCombo->findText(currentSelection));

	// set focus back to old position (if not then the setCurrentIndex would set the focus to the combo box
	if (focusedWidget)
		focusedWidget->setFocus (Qt::OtherFocusReason);
}
/**
 * @brief slot: updates group Box visiblities depending on which device is selected
 * @param index index of selected Item
 * @return
 *	void
 */
void DLDConfigureOB::updateGroupBoxVisibility (int index)
{
	QString flPath = settings->value("FlashBasepath", "ttyUSB").toString ();
	QString obPath = settings->value("OpenBeaconBasepath", "ttyACM").toString ();

	QString selectedItem = mainWindow.deviceCombo->itemText (index);

	if (selectedItem.startsWith (flPath))
		endisableGroupBox (true, false);
	else if (selectedItem.startsWith (obPath))
		endisableGroupBox (false, true);
	else
		endisableGroupBox (false, false);
}
/**
 * @brief slot: shows a basic help for the application
 * @return
 *	void
 */
void DLDConfigureOB::showHelp ()
{
	QDialog * helpDialog = new QDialog;
	Ui::obConfiguratorHelpDialog	help;
	help.setupUi (helpDialog);
	helpDialog->exec ();
	delete (helpDialog);
}
/**
 * @brief slot: shows a about OpenBeacon dialog
 * @return
 *	void
 */
void DLDConfigureOB::aboutOpenBeacon ()
{
	QDialog * aboutOBDialog = new QDialog;
	Ui::aboutOpenBeacon	aboutOB;
	aboutOB.setupUi (aboutOBDialog);
	aboutOBDialog->exec ();
	delete (aboutOBDialog);
}

/**
 * @brief slot: shows a file dialog to select a log file
 * @return
 *	void
 */
void DLDConfigureOB::selectLogFile()
{
	QString logFile = settings->value("logFile", "").toString ();
	QString filepath = QFileDialog::getSaveFileName (this, tr("Save log to"), logFile, "log files (*.log)");
	preferences.logFileEdit->setText (filepath);
}
/**
 * @brief slot: changes the log file
 * @return
 *	void
 */
void DLDConfigureOB::changeLogFile (QString logFilePath)
{
	log->setLogFile (logFilePath);
}
/**
 * @brief slot: execute the selected command
 * @return
 *	void
 */
void DLDConfigureOB::executeCommand ()
{
	QString command = mainWindow.commandCombo->currentText ();
	QString argument = mainWindow.valueEdit->text ();
	if (!argument.isEmpty ())
		command.append (QString (" %1").arg (argument));

	QString timeStamp = QTime::currentTime ().toString ();
	mainWindow.consoleTextEdit->append (QString (tr("[%1] Write: %2")).arg(timeStamp).arg (command));
	device->sendToOB (command);
}
/**
 * @brief slot: opens the selected device
 * @return
 *	void
 */
void DLDConfigureOB::openNewDevice (int index)
{
	// only open if it is a ob device if it is for flashing then opening would block it
	if (mainWindow.deviceCombo->currentText ().startsWith (settings->value("FlashBasepath", "ttyUSB").toString ()))
		return ;

	// close the old devices
	device->stop ();
	device->closeDevice ();

	QString deviceName = mainWindow.deviceCombo->currentText ().prepend("/dev/");
	if (deviceName == "/dev/")
	{
		log->infoLog (QString("Close device: %1").arg(device->getDevicePath()));
		device->stop ();
		return;
	}
	log->infoLog (QString ("Open device: %1").arg(deviceName));
	device->setDevicePath (deviceName);
	int rtc = device->startCommunication ();
	if (rtc == -1) // device name not set
	{
		log->errorLog (QString ("Devicename is empty").arg(deviceName));
		QMessageBox::critical (this, tr("Devicename empty"), tr("Devicename is empty."));
		mainWindow.deviceCombo->setCurrentIndex (0);
		return;
	}else if (rtc == -2) // file does not exist
	{
		log->errorLog (QString ("Device: %1 does not exist").arg(deviceName));
		QMessageBox::critical (this, tr("Device does not exist"), tr("The selected device does not exist."));
		mainWindow.deviceCombo->setCurrentIndex (0);
		return;
	} else if (rtc == -3) // can not open file
	{
		log->errorLog (QString ("Can not open device: %1").arg(deviceName));
		QMessageBox::critical (this, tr("Can not open device"), tr("The selected can not be opened."));
		mainWindow.deviceCombo->setCurrentIndex (0);
		return;
	}
}
/**
 * @brief slot: print the received data to the console ouput
 * @return
 *	void
 */
void DLDConfigureOB::receivedNewData (QString answer)
{
	if (!showRX && answer.startsWith ("RX:"))
		return;
	QString timeStamp = QTime::currentTime ().toString ();
	mainWindow.consoleTextEdit->append (QString ("[%1] %2").arg (timeStamp).arg (answer));
}
/**
 * @brief slot: if a write fails then this slot will be activated
 * @return
 *	void
 */
void DLDConfigureOB::writeFailed ()
{
	QString timeStamp = QTime::currentTime ().toString ();
	mainWindow.consoleTextEdit->append (QString (tr("[%1] Last write failed:")).arg (timeStamp));
}
/**
 * @brief slot: clears the console textbox
 * @return
 *	void
 */
void DLDConfigureOB::clearConsole ()
{
	mainWindow.consoleTextEdit->clear ();
}
/**
 * @brief slot: flash a device with a new image
 * @return
 *	void
 */
void DLDConfigureOB::flashDevice ()
{
	QString imageFile = mainWindow.imagepathEdit->text ();
	if (imageFile.isEmpty ())
	{
		QMessageBox::critical (this, tr("No image file"), tr("You must select an image file."));
		return;
	}
	QString timeStamp = QTime::currentTime ().toString ();

	if (QMessageBox::question (this, tr("Instructions"), tr ("This may take some time do not interrupt or unplug the device. Continue?"), QMessageBox::Yes | QMessageBox::No, QMessageBox::No) == QMessageBox::No)
	{
		QMessageBox::information (this, tr("Aborted"), tr("Flashing aborted."));
		log->infoLog ("Flashing aborted.");
		return ;
	}

	qsrand (QTime::currentTime ().second());
	QString tmpFlashImageFileName = QString ("%1/obImage-%2.bin").arg(QDir::tempPath ()).arg(qrand ());
	QString devicePath = mainWindow.deviceCombo->currentText ();
	QString command = settings->value("sam7Path", "/usr/local/bin/sam7").toString ();
	QFile	tmpFlashImageFile(imageFile);
	tmpFlashImageFile.copy (tmpFlashImageFileName);
	command.append (QString (" -l /dev/%1 -e set_clock -e unlock_regions -e \"flash %2\"").arg(devicePath).arg(tmpFlashImageFileName));
	mainWindow.consoleTextEdit->append (QString (tr("[%1] Flashing started...")).arg (timeStamp));

	setCursor (Qt::WaitCursor);
	log->debugLog (QString("Executing: %1").arg (command));
	batchProcess->start(command);
	batchProcess->waitForFinished (300000); // wait up to 5min
	setCursor (Qt::ArrowCursor);
}
/**
 * @brief slot: select the sam7 binary (needed for flashing
 * @return
 *	void
 */
void DLDConfigureOB::selectSam7File ()
{
	QString lastFile = preferences.sam7PathEdit->text();
	if (lastFile.isEmpty())
		lastFile = settings->value("sam7Path", "/usr/local/bin/sam7").toString ();

	QString filepath = QFileDialog::getOpenFileName(0, tr("Choose the sam7 binary"), lastFile, "sam7 (sam7)");
	preferences.sam7PathEdit->setText (filepath);
}
/**
 * @brief slot: adding stdout output from the process to the console
 * @return
 *	void
 */
void DLDConfigureOB::addCharToConsole ()
{
	mainWindow.consoleTextEdit->append (batchProcess->readAllStandardOutput ());
}
/**
 * @brief slot: print the error the process throwed
 * @param error	the id of the error
 * @return
 *	void
 */
void DLDConfigureOB::printProcessError (QProcess::ProcessError error)
{
	switch (error)
	{
		case QProcess::FailedToStart:
			log->errorLog ("The process failed to start. Either the invoked program is missing, or you may have insufficient permissions to invoke the program.");
			break;
		case QProcess::Crashed:
			log->errorLog ("The process crashed some time after starting successfully.");
			break;
		case QProcess::Timedout:
			log->errorLog ("The last waitFor...() function timed out. The state of QProcess is unchanged, and you can try calling waitFor...() again.");
			break;
		case QProcess::WriteError:
			log->errorLog ("An error occurred when attempting to write to the process. For example, the process may not be running, or it may have closed its input channel.");
			break;
		case QProcess::ReadError:
			log->errorLog ("An error occurred when attempting to read from the process. For example, the process may not be running.");
			break;
		case QProcess::UnknownError:
			log->errorLog ("An unknown error occurred. This is the default return value of error().");
			break;
	}
}
/**
 * @brief slot: prints the finish message, when flashing is done
 * @return
 *	void
 */
void DLDConfigureOB::processFinished (int, QProcess::ExitStatus)
{
	log->infoLog ("Flashing finished");
	QString timeStamp = QTime::currentTime ().toString ();
	mainWindow.consoleTextEdit->append (QString (tr("[%1] Flashing finished")).arg(timeStamp));
	QMessageBox::information (this, tr("Finished"), tr("Flashing was finished.\nNow unplug the device and plug it back in, so the system recognizes it as OpenBeacon node."));
}
/**
 * @brief slot: fill the command list with default values
 * @return
 *	void
 */
void DLDConfigureOB::fillDefaultCommands ()
{
	QDialog * questionDialog = new QDialog;
	Ui::replaceCommandsDialog	question;
	question.setupUi (questionDialog);
	if (questionDialog->exec ()== QDialog::Accepted)
	{
		while (preferences.commandTable->rowCount () > 0)
			preferences.commandTable->removeRow (0);

		if (question.defaultOBCheck->isChecked())
		{
			addCommandTableRow (0, "?", tr("OpenBeacon Help screen"));
			addCommandTableRow (0, "H", tr("OpenBeacon Help screen"));
			addCommandTableRow (0, "S", tr("store transmitter settings"));
			addCommandTableRow (0, "C", tr("print configuration"));
			addCommandTableRow (0, "I", tr("set reader id"));
			addCommandTableRow (0, "FIFO", tr("set FIFO cache lifetime in seconds"));
			addCommandTableRow (0, "0", tr("receive only mode"));
			addCommandTableRow (0, "1", tr("automatic transmit at power level 1"));
			addCommandTableRow (0, "2", tr("automatic transmit at power level 1"));
			addCommandTableRow (0, "3", tr("automatic transmit at power level 1"));
			addCommandTableRow (0, "4", tr("automatic transmit at power level 1"));
		}
		if (question.dldCheck->isChecked())
		{
			addCommandTableRow (0, "D", tr("get configured id"));
			addCommandTableRow (0, "M", tr("get configured mode"));
			addCommandTableRow (0, "U", tr("get uptime of Openbeacon"));
			addCommandTableRow (0, "A", tr("get channel"));
			addCommandTableRow (0, "L", tr("get FIFO lifetime"));
		}
	}
	delete (questionDialog);
}
/**
 * @brief adds one row to the command table of the preferences dialog
 * @return
 *	void
 */
void DLDConfigureOB::addCommandTableRow (int row, QString firstCell, QString secondCell)
{
	QTableWidgetItem * firstCellItem = new QTableWidgetItem(firstCell);
	QTableWidgetItem * secondCellItem = new QTableWidgetItem(secondCell);
	preferences.commandTable->insertRow(row);
	preferences.commandTable->setItem(row, 0, firstCellItem);
	preferences.commandTable->setItem(row, 1, secondCellItem);
}
/**
 * @brief slot: check if the senders input box is filled
 * @return
 *	void
 */
void DLDConfigureOB::checkFilled ()
{
	if (sender ()->objectName () == "flashBasepathEdit")
	{
		if (!preferences.flashBasepathEdit->text ().isEmpty ())
			return;
		preferences.flashBasepathEdit->setFocus (Qt::OtherFocusReason);
	}else if (sender ()->objectName () == "openBeaconBasepathEdit")
	{
		if (!preferences.openBeaconBasepathEdit->text ().isEmpty ())
			return;
		preferences.openBeaconBasepathEdit->setFocus (Qt::OtherFocusReason);
	}
	QMessageBox::critical (this, tr("Error"), QString (tr("The field %1 is not allowed to be empty.")).arg(sender ()->objectName ()));
}

