/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */
#pragma once

#include <QtMsgHandler>
#include <QLoggingCategory>

class DLDLog
{
public:
	static void consoleMessageHandler(QtMsgType type, const QMessageLogContext &context, const QString &msg);
};
