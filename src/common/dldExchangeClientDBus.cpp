 /*
  * dldExchangeClientDBus.cpp  - domestic location detection - Exchange Client DBus Strat
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
#include "dldLog.h"

#include <QtDBus>

/**
 * @brief constructor for DLDExchangeClientDBus class
 * @param logAddress is the pointer of the parents log class
 * @param connectionBasePath service name to which it should connect
 * @return
 *      void
 */
DLDExchangeClientDBus::DLDExchangeClientDBus (DLDLog * pLog, QString connectionBasePath, QString subPath, QString interface)
{
	log = pLog;
	serviceName = connectionBasePath;
	QString path = QString ("/%1").arg(subPath);

	// build up dbus connection:
	dBus = new QDBusConnection (QDBusConnection::sessionBus());

	if (!dBus->sessionBus().isConnected())
	{
		log->errorLog ("Cannot connect to the D-BUS session bus.\nTo start it, run:\n\teval `dbus-launch --auto-syntax`");
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
		log->errorLog ("No known interface detected.");
	log->infoLog (QString("DBus exchange client with serviceName: \"%1\", path: \"%2\" interface: \"%3\" added.").arg(serviceName).arg(path).arg(interface));
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
			emit newStrength (args.at(0).toInt(), args.at(1).toInt(), args.at(2).toDouble ());
			log->debugLog(QString ("DBus recv(new Strength): %1, %2, %3").arg(args.at(0).toInt()).arg(args.at(1).toInt()).arg(args.at(2).toInt()));
		}// else ignore
	} else if (message.member() == "updatedNode")
	{
		if (args.size () == 4)
		{
			emit newNode (args.at(0).toInt(), args.at(1).toDouble (), args.at(2).toDouble (), args.at(3).toDouble ());
			log->debugLog(QString ("DBus recv(new Node): %1, %2, %3, %4").arg(args.at(0).toInt()).arg(args.at(1).toDouble ()).arg(args.at(2).toDouble ()).arg(args.at(3).toDouble ()));
		}// else ignore
	} else if (message.member() == "updatedPosition")
	{
		if (args.size () == 5)
		{
			emit newPosition (args.at(0).toInt(), args.at(1).toInt(), args.at(2).toDouble (), args.at(3).toDouble (), args.at(4).toDouble ());
			log->debugLog (QString ("DBus recv(new Position): %1, %2, %3, %4, %5").arg(args.at(0).toInt()).arg(args.at(1).toInt()).arg(args.at(2).toDouble ()).arg(args.at(3).toDouble ()).arg(args.at(4).toDouble ()));
		}// else ignore
	} else if (message.member () == "updatedMaximumAxisValue")
	{
		if (args.size () == 1)
		{
			emit newMaximumAxisValue (args.at(0).toDouble ());
			log->debugLog (QString ("DBus recv(new max. axis value): %1").arg(args.at(0).toDouble ()));
		}
	}
}
/**
 * @brief calls the getTagList method from the other side
 * @return
 *      QString the tag list
 */
QString DLDExchangeClientDBus::getTagList ()
{
	if (!iFace->isValid())
		return ("");

	QDBusReply<QString> reply = iFace->call("getTagList");
	if (!reply.isValid())
	{
		log->errorLog (QString ("Call failed: %1").arg (qPrintable(reply.error().message())));
		return ("");
	}
	log->debugLog (QString ("Received: %1").arg (reply.value()));
	return (reply.value());
}
/**
 * @brief calls the getNodeList method from the other side
 * @return
 *      QString the node list
 */
QString DLDExchangeClientDBus::getNodeList ()
{
	if (!iFace->isValid())
		return ("");

	QDBusReply<QString> reply = iFace->call("getNodeList");
	if (!reply.isValid())
	{
		log->errorLog (QString ("Call failed: %1").arg (qPrintable(reply.error().message())));
		return ("");
	}
	log->debugLog (QString ("Received: %1").arg (reply.value()));
	return (reply.value());
}
/**
 * @brief calls the getStrengths method from the other side
 * @param tagId the id of which the strength should be returned
 * @return
 *      QString the strength string for the tagId
 */
QString DLDExchangeClientDBus::getStrengths (int tagId)
{
	if (!iFace->isValid())
		return ("");

	QDBusReply<QString> reply = iFace->call("getStrengths", tagId);
	if (!reply.isValid())
	{
		log->errorLog (QString ("Call failed: %1").arg (qPrintable(reply.error().message())));
		return ("");
	}
	log->debugLog (QString ("Received: %1").arg (reply.value()));
	return (reply.value());
}
/**
 * @brief calls the getNodeInfo method from the other side
 * @param deviceId the id of which the node information should be returned
 * @return
 *      QString the nodeInformation string for the deviceId
 */
QString DLDExchangeClientDBus::getNodeInfo (int deviceId)
{
	if (!iFace->isValid())
		return ("");

	QDBusReply<QString> reply = iFace->call("getNodeInfo", deviceId);
	if (!reply.isValid())
	{
		log->errorLog (QString ("Call failed: %1").arg (qPrintable(reply.error().message())));
		return ("");
	}
	log->debugLog (QString ("Received: %1").arg (reply.value()));
	return (reply.value());
}
/**
 * @brief calls the getMaximumAxisValue method from the remote
 * @return
 *      int maximum axis value
 */
double DLDExchangeClientDBus::getMaximumAxisValue ()
{
	if (!iFace->isValid())
		return (0);

	QDBusReply<double> reply = iFace->call("getMaximumAxisValue");
	if (!reply.isValid())
	{
		log->errorLog (QString ("Call failed: %1").arg (qPrintable(reply.error().message())));
		return (0);
	}
	log->debugLog (QString ("Received: %1").arg (reply.value()));
	return (reply.value());
}
