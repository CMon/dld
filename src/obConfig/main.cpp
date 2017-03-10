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

	DLDConfigureOB mainWin;
	mainWin.show();
	return app.exec ();
}
