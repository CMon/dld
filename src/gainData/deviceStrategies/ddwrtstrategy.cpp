/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */
#include "ddwrtstrategy.h"

#include <common/dldLog.h>

#include <QTextStream>
#include <QStringList>

Q_LOGGING_CATEGORY(DDWRT, "dld.gainData.deviceStrategy.ddwrt")


DDWRTStrategy::DDWRTStrategy(const QString & configName)
	: settings(configName, "DDWRTStrategy")
{
	qCDebug(DDWRT()) << "DDWRT Strategy Configuration is located in" << settings.fileName();

	readConfiguration ();

	checkTimer.setSingleShot(false);
//	connect(&checkTimer, &QTimer::timeout, this, &DDWRTStrategy::checkRouters);
}

void DDWRTStrategy::readConfiguration()
{
	routers.clear();

	maximumDBValue = settings.value("maximumDBValue", 100).toInt();
	checkFrequenzy = settings.value("checkFrequenzy", 1).toInt();

	foreach (const QString & group, settings.childGroups())
	{
		RouterInfo info;
		settings.beginGroup(group);

		info.networkRequest.setUrl("http://" + group + "/info.live.htm");
		info.networkRequest.setHeader(QNetworkRequest::ContentTypeHeader, "utf-8");

		info.id = settings.value("id", 0).toInt();
		info.position.setX(settings.value("x", 0).toDouble());
		info.position.setX(settings.value("y", 0).toDouble());
		info.position.setX(settings.value("z", 0).toDouble());

		if (routers.contains(info.id)) {
			qCCritical(DDWRT()) << "Invalid configuration every Router needs its own id, skipping rest";
			return;
		}
		routers[info.id] = info;
		settings.endGroup ();
	}
}

void DDWRTStrategy::connectDevices()
{
	checkTimer.setInterval(checkFrequenzy * 1000);
	checkTimer.start();
}

void DDWRTStrategy::disconnectDevices()
{
	checkTimer.stop();
}

void DDWRTStrategy::addDevice(const QString & path)
{
	Q_UNUSED(path)
}

void DDWRTStrategy::removeDevice(const QString & path)
{
	Q_UNUSED(path)
}

void DDWRTStrategy::printSampleConfig() const
{
	QTextStream out (stdout);
	out << "The following gives an example of two configuration entries for the ddwrt configuration ";
	out << "and belongs into: " << settings.fileName () << endl << endl;
	out	<< "[ip]" << endl
		<< "id=0" << endl
		<< "x=0" << endl
		<< "y=0" << endl
		<< "z=0" << endl;
}

