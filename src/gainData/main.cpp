 /*
  * main.cpp  - domestic location detection - gain data daemon main
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
#include <signal.h>
#include <sys/types.h>
#include <sys/socket.h>

#include "dldGain.h"
#include "../common/dldLog.h"

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
int main(int argc, char *argv[])
{
	QTextStream out (stdout);
	int verbosity = -1;
	int optionIndex = 0;
	QString logFile;
	QString strategy;

	struct option longOptions[] = {
		{"verbosity",	1, 0, 'v'},
		{"logfile",	1, 0, 'l'},
		{"strategy",	1, 0, 's'}
	};

	while (1)
	{
		int c = getopt_long (argc, argv, "v:l:s:", longOptions, &optionIndex);
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
			case 's':
				strategy = optarg;
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
	DLDGain * mainGain = new DLDGain (verbosity, logFile, strategy);
	setupUnixSignalHandlers ();

	out << "Data gain daemon is running..." << endl;
	app.exec ();
	delete (mainGain);
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
	out << "OpenBeacon gain data daemon programmed and copyright by Simon Schaefer" << endl;
	out << "OpenBeacon is a project from http://www.openbeacon.org/" << endl << endl;
	out << "Usage: " << endl;
	out << "\t" << progname << " [-v <verbosityLevel>] [-l <logFile>] [-s <strategyName>]" << endl << endl;
	out << "Possible verbosity level values:" << endl;
	out << "\t0\tQuiet mode - do not print anything." << endl;
	out << "\t1\tError mode - just print errors." << endl;
	out << "\t2\tInfo mode - print some info messages." << endl;
	out << "\t3\tDebug mode - print some debug stuff too." << endl;
	out << "Possible strategies:" << endl;
	out << "\tOpenBeaconUSBStrategy\tStrategy for the USB OpenBeacon nodes" << endl;
	out << "\tDLDSimulateStrategy\tStrategy for a hardware simulation interface" << endl;
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
