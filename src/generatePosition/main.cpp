 /*
  * main.cpp  - domestic location detection - main for generate position daemon
  *
  * Copyright (c) by Simon Sch�fer <Simon.Schaefer@koeln.de>
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
#include <QCoreApplication>
#include <QString>
#include <QTextStream>

#include <getopt.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/socket.h>

#include "../common/dldLog.h"
#include "dldGeneratePosition.h"

// Predeclaration
void usage (QString progname);
int setupUnixSignalHandlers ();
void sigChild (int signo);
/**
 * @brief main for starting the application and parsing the arguments
 * @param argc argument count
 * @param argv argument values
 * @return
 *	int	0 ok, else not ok
 */
int main (int argc, char * argv[])
{
	QTextStream out (stdout);
	int verbosity = -1;
	int optionIndex = 0;
	QString logFile;

	struct option longOptions[] = {
		{"verbosity",	1, 0, 'v'},
		{"logfile",	1, 0, 'l'}
	};

	while (1)
	{
		int c = getopt_long (argc, argv, "v:l:", longOptions, &optionIndex);
		if (c == -1)
			break;
		switch (c)
		{
			case 'v':
				verbosity = atoi (optarg);
				break;
			case 'l':
				logFile = optarg;
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

	QCoreApplication app(argc, argv);
	DLDGeneratePosition * mainGenPos = new DLDGeneratePosition (verbosity, logFile);
	setupUnixSignalHandlers ();

	out << "generate position daemon is running..." << endl;
	app.exec ();
	delete (mainGenPos);
	return 0;
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
	out << "OpenBeacon generate position daemon programmed and copyright by Simon Schaefer" << endl;
	out << "OpenBeacon is a project from http://www.openbeacon.org/" << endl << endl;
	out << "Usage: " << endl;
	out << "\t" << progname << " [-v <verbosityLevel>] [-l <logFile>]" << endl << endl;
	out << "Possible verbosity level values:" << endl;
	out << "\t0\tQuiet mode - do not print anything." << endl;
	out << "\t1\tError mode - just print errors." << endl;
	out << "\t2\tInfo mode - print some info messages." << endl;
	out << "\t3\tDebug mode - print some debug stuff too." << endl;
	out << endl << endl;
}
/**
 * @brief registers the signal function into the unix signal handler
 * @return
 *	int	returns != 0 if register of one action failed
 */
int setupUnixSignalHandlers ()
{
	struct sigaction term;

	term.sa_handler = sigChild;
	sigemptyset(&term.sa_mask);
	term.sa_flags = 0;
	term.sa_flags |= SA_RESTART;

	if (sigaction(SIGHUP, &term, 0) > 0)
		return 1;

	if (sigaction(SIGINT, &term, 0) > 0)  // if CTRL+C or interrupt(2) signal is send
		return 2;

	if (sigaction(SIGTERM, &term, 0) > 0) // if terminate (15) signal is send
		return 3;

	return 0;
}
/**
 * @brief the function that is called if one of the signals was received (basicly stops the dldGain mainloop)
 * @param signo the catched signal number
 * @return
 *	void
 */
void sigChild (int signo)
{
	exit (1);
}
