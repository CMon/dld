 /*
  * main.cpp  - domestic location detection - OpenBeacon Configurator main
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
#include <QApplication>
#include <QString>
#include <QTextStream>
#include <getopt.h>

#include "obConfig.h"
#include "../common/dldLog.h"

// Predeclaration
void usage (QString progname);
/**
 * @brief main for starting the application and parsing the arguments
 * @param argc argument count
 * @param argv argument values
 * @return
 *	int	0 ok, else not ok
 */
int main(int argc, char *argv[])
{
	int verbosity = -1;
	int optionIndex = 0;

	struct option longOptions[] = {
		{"verbosity",	1, 0, 'v'}
	};
	while (1)
	{
		int c = getopt_long (argc, argv, "v:", longOptions, &optionIndex);
		if (c == -1)
			break;
		switch (c)
		{
			case 'v':
				verbosity = atoi (optarg);
				break;
			default:
				usage (QString (argv[0]));
				return (1);
		}
	}

	switch (verbosity)
	{
		case 0:
			verbosity = DLDLog::LOG_LEVEL_QUIET;
			break;
		case 1:
			verbosity = DLDLog::LOG_LEVEL_ERROR;
			break;
		case 2:
			verbosity = DLDLog::LOG_LEVEL_INFO;
			break;
		case 3:
			verbosity = DLDLog::LOG_LEVEL_DEBUG;
			break;
		default:
			verbosity = DLDLog::LOG_LEVEL_ERROR;
			break;
	}

	QApplication app(argc, argv);
	DLDConfigureOB * mainWin = new DLDConfigureOB(verbosity);
	mainWin->show();
	int rtc = app.exec ();
	delete (mainWin);
	return rtc;
}
/**
 * @brief usage for this application
 * @param progname name of the launching program
 * @return
 *	void
 */
void usage (QString progname)
{
	QTextStream out (stdout);
	out << "OpenBeacon Configurator programmed and copyright by Simon Schaefer" << endl;
	out << "OpenBeacon is a project from http://www.openbeacon.org/" << endl << endl;
	out << "Usage: " << endl;
	out << "\t" << progname << " [-v <verbosityLevel>]" << endl << endl;
	out << "Possible verbosity level values:" << endl;
	out << "\t0\tQuiet mode - do not print anything." << endl;
	out << "\t1\tError mode - just print errors." << endl;
	out << "\t2\tInfo mode - print some info messages." << endl;
	out << "\t3\tDebug mode - print some debug stuff too." << endl;
	out << endl << endl;
}
