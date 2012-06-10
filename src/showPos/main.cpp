/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */
#include <common/dldLog.h>
#include <showPos/dldShowPos.h>

#include <QApplication>
#include <QString>
#include <QTextStream>

#include <getopt.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/socket.h>

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

	QApplication app(argc, argv);
	DLDShowPos * mainShowPos = new DLDShowPos (verbosity, logFile);
	setupUnixSignalHandlers ();
	mainShowPos->show ();
	int rtc = app.exec ();
	delete (mainShowPos);
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
	out << "OpenBeacon show position application programmed and copyright by Simon Schaefer" << endl;
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
