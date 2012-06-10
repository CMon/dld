/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */
#pragma once

#include <QFile>

class QString;

class DLDLog
{
public:
	DLDLog ();
	~DLDLog ();
	bool setLogFile (QString filepath);
	void setLogLevel (int level);
	void setLogType (int type);

	void debugLog (QString message);
	void errorLog (QString message);
	void infoLog (QString message);

	// class defines:
	static const int LOG_TO_CONSOLE		= 0;
	static const int LOG_TO_FILE		= 1;

	static const int LOG_LEVEL_QUIET	= 0;
	static const int LOG_LEVEL_ERROR	= 2;
	static const int LOG_LEVEL_INFO		= 3;
	static const int LOG_LEVEL_DEBUG	= 4;

private:
// Methods
	void log (int mode, QString message);

// Attributes:
	QString		logFilePath;
	QFile *		logFile;
	int		logLevel;
	int		logType;
};
