/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */

/** @class DLDExchangeServerDBusStrength dldExchangeServerDBusStrength.h
 *
 * @author Simon Schaefer
 *
 * @date 18.02.2008
 *
 * @version 1.0
 * <br> Class for the DLD exchange server D-Bus Strength strategy
 */
#include "dldExchangeServerDBusStrength.h"

#include <common/dldExchangeServerStrategy.h>
#include <common/dldLog.h>

#include <QString>
#include <QtDBus>
#include <QVariant>
#include <QVector3D>

Q_LOGGING_CATEGORY(DBUS_SERVER_STRENGTH, "dld.dbus.server.strength")

/**
 * @brief constructor for DLDExchangeServerDBusStrength class
 * @param connectionBasePath in this case its the service name
 * @param subPath the subpath for the service
 * @return
 *      void
 */
DLDExchangeServerDBusStrength::DLDExchangeServerDBusStrength (const QString & connectionBasePath, const QString & subPath)
{
// build up dbus connection:
	dBus = new QDBusConnection ("");
	dBus->connectToBus (QDBusConnection::ActivationBus, "");
	if (!dBus->sessionBus().isConnected())
	{
		qCCritical(DBUS_SERVER_STRENGTH) << "Cannot connect to the D-BUS session bus.\nTo start it, run:\n\teval `dbus-launch --auto-syntax`";
		return ;
	}
	if (!dBus->sessionBus().registerService(connectionBasePath))
	{
		qCCritical(DBUS_SERVER_STRENGTH) << QString ("%1").arg(qPrintable(QDBusConnection::sessionBus().lastError().message()));
		return ;
	}
	dBus->sessionBus().registerObject(QString ("/%1").arg(subPath), this, QDBusConnection::ExportScriptableSlots | QDBusConnection::ExportAllSignals);
}
/**
 * @brief destructor for DLDExchangeServerDBusStrength class
 * @return
 *      void
 */
DLDExchangeServerDBusStrength::~DLDExchangeServerDBusStrength ()
{
	if (dBus)
		delete (dBus);
}
/**
 * @brief slot: updates the node data in the internal struct and emits the signal updatedNode, this slot is used to work in both directions
 * @param id	id of the node to update
 * @param x	x coordination of the node
 * @param y	y coordination of the node
 * @param z	z coordination of the node
 * @return
 *      void
 */
void DLDExchangeServerDBusStrength::updateNode (const QString & id, double x, double y, double z)
{
	nodeInfo[id] = QVector3D(x, y, z);
	emit updatedNode (id, x, y, z);
}
/**
 * @brief slot: returns the tagId string of all seen tags
 * @return
 *      QString returns tagId string; tagId1|tagId2|...
 */
QString DLDExchangeServerDBusStrength::getTagList () const
{
	QString rtString;
	if (tagInfo.isEmpty())
		return ("noTags");
	foreach (const QString & tagId, tagInfo.keys()) {
		rtString.append(QString ("%1|").arg(tagId));
	}
	return (rtString);
}
/**
 * @brief slot: returns the nodeId string of all attached nodes
 * @return
 *      QString returns tagId string; nodeId|nodeId||...
 */
QString DLDExchangeServerDBusStrength::getNodeList () const
{
	QString rtString;
	if (nodeInfo.isEmpty())
		return ("noNodes");
	foreach (const QString & tagId, nodeInfo.keys()) {
		rtString.append (QString ("%1|").arg(tagId));
	}
	return (rtString);
}
/**
 * @brief slot: returns the strengthString of a tag
 * @param tagId the id of the tag
 * @return
 *      QString return strength string; nodeId1=strength1|nodeId2=strength2|...
 */
QString DLDExchangeServerDBusStrength::getStrengths (const QString & tagId) const
{
	QString rtString;
	if (tagInfo.isEmpty())
		return ("noTags");
	StrengthType	strengths = tagInfo[tagId];
	if (strengths.isEmpty())
		return ("noStrengthInformation");
	QMapIterator<QString, double> i(strengths);
	while (i.hasNext())
	{
		i.next();
		rtString.append (QString ("%1=%2|").arg(i.key()).arg(i.value()));
	}
	return (rtString);
}
/**
 * @brief slot: updates the strength data of a tag in the internal struct and emits the signal updatedStrength, this slot is used to work in both directions
 * @param deviceId	id of the device whos strength is reported
 * @param tagId		id of the tag whos strength is received
 * @param strength	the strength of the tag
 * @return
 *      void
 */
void DLDExchangeServerDBusStrength::updateStrength (const QString & deviceId, const QString & tagId, double strength)
{
	StrengthType tmp = tagInfo[tagId];
	tmp.insert (deviceId, strength);
	tagInfo.insert (tagId, tmp);

	emit updatedStrength (deviceId, tagId, strength);
}
/**
 * @brief slot: returns the position string of a node device
 * @param deviceId the id of the device
 * @return
 *      QString return position string; x=<x>|y=<y>|z=<z>
 */
QString DLDExchangeServerDBusStrength::getNodeInfo (const QString & deviceId) const
{
	if (nodeInfo.isEmpty())
		return ("noNodes");
	if (!nodeInfo.contains(deviceId))
		return ("no node information");

	QString rtc = QString ("x=%1|y=%2|z=%3").arg(nodeInfo[deviceId].x()).arg(nodeInfo[deviceId].y()).arg(nodeInfo[deviceId].z());
	return (rtc);
}
/**
 * @brief slot: updates the position data of the tag
 * @param tagId		id of the tag
 * @param timeStamp	timestamp of the position arrival
 * @param x		x position of the tag
 * @param y		y position of the tag
 * @param z		z position of the tag
 * @return
 *      void
 */
void DLDExchangeServerDBusStrength::updatePosition (const QString & tagId, int timestamp, double x, double y, double z)
{
	Q_UNUSED(tagId)
	Q_UNUSED(timestamp)
	Q_UNUSED(x)
	Q_UNUSED(y)
	Q_UNUSED(z)
	// do nothing
}
/**
 * @brief set the maximum axis value
 * @param maximumAxisValue	maximum axis value
 * @return
 *      void
 */
void DLDExchangeServerDBusStrength::setMaximumAxisValue (double maximumAxisValue)
{
	this->maximumAxisValue = maximumAxisValue;
	emit updatedMaximumAxisValue (maximumAxisValue);
}
/**
 * @brief slot: returns the maximum axis value (for the device)
 * @return
 *      int value
 */
double DLDExchangeServerDBusStrength::getMaximumAxisValue () const
{
	return (maximumAxisValue);
}
