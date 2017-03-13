/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */
/** @class DLDExchangeClientDBus dldExchangeClientDBus.h
 *
 * @author Simon Schaefer
 *
 * @date 24.02.2008
 *
 * @version 1.0
 * <br> Class for the DLD exchange client D-Bus strategy
 */
#include "dldExchangeClientDBus.h"

#include <common/dldLog.h>

#include <QtDBus>

Q_LOGGING_CATEGORY(DBUS_CLIENT, "dld.dbus.client")

/**
 * @brief constructor for DLDExchangeClientDBus class
 * @param connectionBasePath service name to which it should connect
 * @return
 *      void
 */
DLDExchangeClientDBus::DLDExchangeClientDBus (const QString & connectionBasePath, const QString & subPath, const QString & interface)
{
	serviceName = connectionBasePath;
	QString path = QString ("/%1").arg(subPath);

	// build up dbus connection:
	dBus = new QDBusConnection (QDBusConnection::sessionBus());

	if (!dBus->sessionBus().isConnected())
	{
		qCCritical(DBUS_CLIENT) << "Cannot connect to the D-BUS session bus.\nTo start it, run:\n\teval `dbus-launch --auto-syntax`";
		return ;
	}
	iFace = new QDBusInterface (connectionBasePath, path, interface, dBus->sessionBus ());

	dBus->connect (serviceName, path, interface, "updatedNode", this, SLOT(parseMessage(QDBusMessage)));
	dBus->connect (serviceName, path, interface, "updatedMaximumAxisValue", this, SLOT(parseMessage(QDBusMessage)));
	if (interface.contains ("strength", Qt::CaseInsensitive))
		dBus->connect (serviceName, path, interface, "updatedStrength", this, SLOT(parseMessage(QDBusMessage)));
	else if (interface.contains ("position", Qt::CaseInsensitive))
		dBus->connect (serviceName, path, interface, "updatedPosition", this, SLOT(parseMessage(QDBusMessage)));
	else
		qCCritical(DBUS_CLIENT) << "No known interface detected.";
	qCInfo(DBUS_CLIENT) << QString("DBus exchange client with serviceName: \"%1\", path: \"%2\" interface: \"%3\" added.").arg(serviceName).arg(path).arg(interface);
}
/**
 * @brief destructor for DLDExchangeClientDBus class
 * @return
 *      void
 */
DLDExchangeClientDBus::~DLDExchangeClientDBus()
{
	if (dBus)
		delete (dBus);
	if (iFace)
		delete (iFace);
}
/**
 * @brief slot: parses the dbus signals and emits the signals if necessary
 * @param message dbus message to parse
 * @return
 *      void
 */
void DLDExchangeClientDBus::parseMessage(const QDBusMessage &message)
{
	// only parse signals!
	if (message.type() != QDBusMessage::SignalMessage)
		return;

	QList<QVariant> args = message.arguments();
	if (message.member() == "updatedStrength")
	{
		if (args.size () == 3)
		{
			emit newStrength (args.at(0).toString(), args.at(1).toString(), args.at(2).toDouble ());
			qCDebug(DBUS_CLIENT) << QString ("DBus recv(new Strength): %1, %2, %3").arg(args.at(0).toString()).arg(args.at(1).toString()).arg(args.at(2).toInt());
		}// else ignore
	} else if (message.member() == "updatedNode")
	{
		if (args.size () == 4)
		{
			emit newNode (args.at(0).toString(), args.at(1).toDouble (), args.at(2).toDouble (), args.at(3).toDouble ());
			qCDebug(DBUS_CLIENT) << QString ("DBus recv(new Node): %1, %2, %3, %4").arg(args.at(0).toString()).arg(args.at(1).toDouble ()).arg(args.at(2).toDouble ()).arg(args.at(3).toDouble ());
		}// else ignore
	} else if (message.member() == "updatedPosition")
	{
		if (args.size () == 5)
		{
			emit newPosition (args.at(0).toString(), args.at(1).toInt(), args.at(2).toDouble (), args.at(3).toDouble (), args.at(4).toDouble ());
			qCDebug(DBUS_CLIENT) << QString ("DBus recv(new Position): %1, %2, %3, %4, %5").arg(args.at(0).toString()).arg(args.at(1).toInt()).arg(args.at(2).toDouble ()).arg(args.at(3).toDouble ()).arg(args.at(4).toDouble ());
		}// else ignore
	} else if (message.member () == "updatedMaximumAxisValue")
	{
		if (args.size () == 1)
		{
			emit newMaximumAxisValue (args.at(0).toDouble ());
			qCDebug(DBUS_CLIENT) << QString ("DBus recv(new max. axis value): %1").arg(args.at(0).toDouble ());
		}
	}
}
/**
 * @brief calls the getTagList method from the other side
 * @return
 *      QString the tag list
 */
QString DLDExchangeClientDBus::getTagList () const
{
	if (!iFace->isValid())
		return ("");

	QDBusReply<QString> reply = iFace->call("getTagList");
	if (!reply.isValid())
	{
		qCWarning(DBUS_CLIENT) << QString ("Call failed: %1").arg (qPrintable(reply.error().message()));
		return ("");
	}
	qCDebug(DBUS_CLIENT) << QString ("Received: %1").arg (reply.value());
	return (reply.value());
}
/**
 * @brief calls the getNodeList method from the other side
 * @return
 *      QString the node list
 */
QString DLDExchangeClientDBus::getNodeList () const
{
	if (!iFace->isValid())
		return ("");

	QDBusReply<QString> reply = iFace->call("getNodeList");
	if (!reply.isValid())
	{
		qCWarning(DBUS_CLIENT) << QString ("Call failed: %1").arg (qPrintable(reply.error().message()));
		return ("");
	}
	qCDebug(DBUS_CLIENT) << QString ("Received: %1").arg (reply.value());
	return (reply.value());
}
/**
 * @brief calls the getStrengths method from the other side
 * @param tagId the id of which the strength should be returned
 * @return
 *      QString the strength string for the tagId
 */
QString DLDExchangeClientDBus::getStrengths (const QString & tagId) const
{
	if (!iFace->isValid())
		return ("");

	QDBusReply<QString> reply = iFace->call("getStrengths", tagId);
	if (!reply.isValid())
	{
		qCWarning(DBUS_CLIENT) << QString ("Call failed: %1").arg (qPrintable(reply.error().message()));
		return ("");
	}
	qCDebug(DBUS_CLIENT) << QString ("Received: %1").arg (reply.value());
	return (reply.value());
}
/**
 * @brief calls the getNodeInfo method from the other side
 * @param deviceId the id of which the node information should be returned
 * @return
 *      QString the nodeInformation string for the deviceId
 */
QString DLDExchangeClientDBus::getNodeInfo (const QString & deviceId) const
{
	if (!iFace->isValid())
		return ("");

	QDBusReply<QString> reply = iFace->call("getNodeInfo", deviceId);
	if (!reply.isValid())
	{
		qCWarning(DBUS_CLIENT) << QString ("Call failed: %1").arg (qPrintable(reply.error().message()));
		return ("");
	}
	qCDebug(DBUS_CLIENT) << QString ("Received: %1").arg (reply.value());
	return (reply.value());
}
/**
 * @brief calls the getMaximumAxisValue method from the remote
 * @return
 *      int maximum axis value
 */
double DLDExchangeClientDBus::getMaximumAxisValue () const
{
	if (!iFace->isValid())
		return (0);

	QDBusReply<double> reply = iFace->call("getMaximumAxisValue");
	if (!reply.isValid())
	{
		qCWarning(DBUS_CLIENT) << QString ("Call failed: %1").arg (qPrintable(reply.error().message()));
		return (0);
	}
	qCDebug(DBUS_CLIENT) << QString ("Received: %1").arg (reply.value());
	return (reply.value());
}
