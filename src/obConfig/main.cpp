/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */

#include <common/dldLog.h>
#include <obConfig/obConfig.h>

#include <QApplication>
#include <QString>
#include <QTextStream>

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
	QApplication app(argc, argv);
	qInstallMessageHandler(DLDLog::consoleMessageHandler);

	DLDConfigureOB * mainWin = new DLDConfigureOB();
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
	out << "\t" << progname << endl << endl;
}
