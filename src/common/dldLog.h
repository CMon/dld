 /*
  * dldLog.h  - domestic location detection - logging class
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
#ifndef __DLDLOG_H
#define __DLDLOG_H

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

#endif
