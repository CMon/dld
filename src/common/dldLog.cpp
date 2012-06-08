 /*
  * dldLog.cpp  - domestic location detection - logging class
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
 /** @class logging dldLog.h
 *
 * @author Simon Schaefer
 *
 * @date 09.02.2008
 *
 * @version 1.0
 * <br> Class for logging
  */
#include <QString>
#include <QFile>
#include <QTextStream>

#include "dldLog.h"
/**
 * @brief constructor for domestic location detection logger
 * @return
 *      void
 */
DLDLog::DLDLog ()
{
	logLevel = LOG_LEVEL_ERROR; // print at least the ERROR messages
	logFile = 0;
}
/**
 * @brief destructor for domestic location detection logger
 * @return
 *      void
 */
DLDLog::~DLDLog ()
{
	if (logFile)
	{
		if (logFile->isOpen())
			logFile->close();
		delete (logFile);
	}
}
/**
 * @brief sets the log file that will be used
 * @param filepath	the path to the file that should be used
 * @return
 *      bool	true if file could be opened, false if not
 */
bool DLDLog::setLogFile (QString filepath)
{
	logFilePath = filepath;
	if (logFile)
	{
		if (logFile->isOpen())
			logFile->close();
		delete (logFile);
	}
	if (filepath.isEmpty())
	{
		setLogType (LOG_TO_CONSOLE);
	}
	logFile = new QFile (logFilePath);
	if (!logFile->open (QIODevice::WriteOnly | QIODevice::Text | QIODevice::Append | QIODevice::Unbuffered))
		return (false);
	setLogType (LOG_TO_FILE);
	return (true);
}
/**
 * @brief sets log level
 * @param level	the highest level that should be logged
 * @return
 *      void
 * <br>The available levels are:<br>
 * DLDLog::LOG_LEVEL_ERROR <br>
 * DLDLog::LOG_LEVEL_INFO <br>
 * DLDLog::LOG_LEVEL_DEBUG <br>
 * in this order. If DLDLog::LOG_LEVEL_INFO is chosen then it will log ERROR and INFO but no DEBUG messages.
 */
void DLDLog::setLogLevel (int level)
{
	logLevel = level;
}
/**
 * @brief sets log type
 * @param type	how should the logging be done
 * @return
 *      void
 * <br>The available types are:<br>
 * DLDLog::LOG_TO_CONSOLE <br>
 * DLDLog::LOG_TO_FILE <br>
 * If DLDLog::LOG_TO_FILE is chosen then it will log to an file otherwise to the console.
 */
void DLDLog::setLogType (int type)
{
	logType = type;
}
/**
 * @brief writes the log message to the selected output
 * @param level		which level was chosen for the logging
 * @param message	the message that should be logged
 * @return
 *      void
 */
void DLDLog::log (int level, QString message)
{
	QString addMessage;
	switch (level)
	{
		case LOG_LEVEL_INFO:
			addMessage = "INFO: %1\n";
			break;
		case LOG_LEVEL_ERROR:
			addMessage = "ERROR: %1\n";
			break;
		case LOG_LEVEL_DEBUG:
		default: // everything that is not specified goes to debug
			addMessage = "DEBUG: %1\n";
			break;
	}
	addMessage = addMessage.arg (message);
	switch (logType)
	{
		case LOG_TO_FILE:
			logFile->write (addMessage.toLocal8Bit());
			break;
		case LOG_TO_CONSOLE:
		default: // if invalid then log to console
			QTextStream out(stdout);
			out << addMessage;
			break;
	}
}
/**
 * @brief writes debug log message
 * @param message	the message that should be logged
 * @return
 *      void
 */
void DLDLog::debugLog (QString message)
{
	if (logLevel >= LOG_LEVEL_DEBUG)
		log (LOG_LEVEL_DEBUG, message);
}
/**
 * @brief writes error log message
 * @param message	the message that should be logged
 * @return
 *      void
 */
void DLDLog::errorLog (QString message)
{
	if (logLevel >= LOG_LEVEL_ERROR)
		log (LOG_LEVEL_ERROR, message);
}
/**
 * @brief writes info log message
 * @param message	the message that should be logged
 * @return
 *      void
 */
void DLDLog::infoLog (QString message)
{
	if (logLevel >= LOG_LEVEL_INFO)
		log (LOG_LEVEL_INFO, message);
}
