/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */

#include <common/dldLog.h>
#include <gainData/dldGain.h>

#include <QApplication>
#include <QCommandLineParser>
#include <QString>
#include <QTextStream>

#include <getopt.h>
#include <signal.h>

Q_LOGGING_CATEGORY(GAINDATA_MAIN, "dld.gainData.main")

// Predeclaration
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
	QApplication app(argc, argv);
	qInstallMessageHandler(DLDLog::consoleMessageHandler);

	QCommandLineParser cmdParser;
	cmdParser.setApplicationDescription("Gain data daemon");
	cmdParser.addHelpOption();
	QCommandLineOption strategyOpt(QStringList() << "s" << "strategy", "Select strategy to use, available options: OpenBeaconUSBStrategy, DLDSimulateStrategy(default)", "strategy");
	cmdParser.addOption(strategyOpt);

	cmdParser.process(app);

	QString strategy = "DLDSimulateStrategy";
	if (cmdParser.isSet(strategyOpt)) strategy = cmdParser.value(strategyOpt);

	DLDGain mainGain(strategy);
	Q_UNUSED(mainGain)
	setupUnixSignalHandlers ();

	qCInfo(GAINDATA_MAIN) << "Data gain daemon started" << endl;
	return app.exec();
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
	qCCritical(GAINDATA_MAIN) << "GainData finished with signal: " << signo;
	exit (1);
}
