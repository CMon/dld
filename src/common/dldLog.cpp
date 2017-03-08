/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */
 /** @class logging dldLog.h
 *
 * @author Simon Schaefer
 *
 * @date 2017.03.07
 *
 * @version 1.0
 * <br> Class for logging
 */
#include "dldLog.h"

#include <QDateTime>

void DLDLog::consoleMessageHandler(QtMsgType type, const QMessageLogContext &context, const QString &msg)
{
	const QDateTime now = QDateTime::currentDateTime();
	char typeStr;
	switch (type) {
		case QtDebugMsg:    typeStr = 'D'; break;
#if QT_VERSION >= 0x050500
		case QtInfoMsg:     typeStr = 'I'; break;
#endif
		case QtWarningMsg:  typeStr = 'W'; break;
		case QtCriticalMsg: typeStr = 'C'; break;
		case QtFatalMsg:    typeStr = 'F'; break;
	}
	fprintf(stdout, "%s %c %20s:%4d %15s:  %s\n", qPrintable(now.toString(Qt::ISODate)), typeStr, basename((char *)context.file), context.line, context.category, msg.toLocal8Bit().constData());
	fflush(stdout);
}
