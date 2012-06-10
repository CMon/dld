/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */

/** @class DLDExchangeServerDBusPosition dldExchangeServerDBusPosition.h
 *
 * @author Simon Schaefer
 *
 * @date 18.02.2008
 *
 * @version 1.0
 * <br> Class for the DLD exchange server D-Bus Position strategy
 */
#include "dldExchangeServerDBusPosition.h"

#include <common/dldLog.h>
#include <common/dldExchangeServerStrategy.h>

#include <QVariant>
#include <QString>
#include <QtDBus>

/**
 * @brief constructor for DLDExchangeServerDBusPosition class
 * @param logAddress is the pointer of the parents log class
 * @param connectionBasePath in this case its the service name
 * @param subPath the subpath for the service
 * @return
 *      void
 */
DLDExchangeServerDBusPosition::DLDExchangeServerDBusPosition (DLDLog * pLog, QString connectionBasePath, QString subPath)
{
	log = pLog;

// build up dbus connection:
	dBus = new QDBusConnection ("");
	dBus->connectToBus (QDBusConnection::ActivationBus, "");
	if (!dBus->sessionBus().isConnected())
	{
		log->errorLog ("Cannot connect to the D-BUS session bus.\nTo start it, run:\n\teval `dbus-launch --auto-syntax`");
		return ;
	}
	if (!dBus->sessionBus().registerService(connectionBasePath))
	{
		log->errorLog (QString ("%1").arg(qPrintable(QDBusConnection::sessionBus().lastError().message())));
		return ;
	}
	dBus->sessionBus().registerObject(QString ("/%1").arg(subPath), this, QDBusConnection::ExportScriptableSlots | QDBusConnection::ExportAllSignals);
}
/**
 * @brief destructor for DLDExchangeServerDBusPosition class
 * @return
 *      void
 */
DLDExchangeServerDBusPosition::~DLDExchangeServerDBusPosition ()
{
	if (dBus)
		delete (dBus);
}
/**
 * @brief slot: updates the node data in the internal struct and emits the signal updatedNode, this slot is used to work in both directions
 * @return
 *      void
 */
void DLDExchangeServerDBusPosition::updateNode (int id, double x, double y, double z)
{
	ThreeDPoint pos;
	pos.x = x;
	pos.y = y;
	pos.z = z;

	nodeInfo.insert (id, pos);
	emit updatedNode (id, x, y, z);
}
/**
 * @brief slot: returns the tagId string of all seen tags
 * @return
 *      QString returns tagId string; tagId1|tagId2|...
 */
QString DLDExchangeServerDBusPosition::getTagList ()
{
	QString rtString;
	if (tagPosition.isEmpty())
		return ("noTags");
	QMapIterator<int, TagPositionInformation> i(tagPosition);
	while (i.hasNext())
	{
		i.next();
		rtString.append (QString ("%1|").arg(i.key()));
	}
	return (rtString);
}
/**
 * @brief slot: returns the nodeId string of all attached nodes
 * @return
 *      QString returns tagId string; nodeId|nodeId||...
 */
QString DLDExchangeServerDBusPosition::getNodeList ()
{
	QString rtString;
	if (nodeInfo.isEmpty())
		return ("noNodes");
	QMapIterator<int, ThreeDPoint> i(nodeInfo);
	while (i.hasNext())
	{
		i.next();
		rtString.append (QString ("%1|").arg(i.key()));
	}
	return (rtString);
}
/**
 * @brief slot: returns the strengthString of a tag
 * @param tagId the id of the tag
 * @return
 *      QString return strength string; nodeId1=strength1|nodeId2=strength2|...
 */
QString DLDExchangeServerDBusPosition::getPosition (int tagId)
{
	QString rtString;
	if (tagPosition.isEmpty())
		return ("noPositions");

	if (!tagPosition.contains (tagId))
		return ("noPositionInformation");
	TagPositionInformation posInfo = tagPosition[tagId];

	rtString.append (QString ("timestamp=%1|x=%2|y=%3|z=%4").arg(posInfo.timestamp).arg(posInfo.x).arg(posInfo.y).arg(posInfo.z));
	return (rtString);
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
void DLDExchangeServerDBusPosition::updatePosition (int tagId, int timestamp, double x, double y, double z)
{
	TagPositionInformation	posInfo;
	posInfo.timestamp = timestamp;
	posInfo.x = x;
	posInfo.y = y;
	posInfo.z = z;

	tagPosition.insert (tagId, posInfo);
	emit updatedPosition (tagId, timestamp, x, y, z);
}
/**
 * @brief slot: returns the position string of a node device
 * @param deviceId the id of the device
 * @return
 *      QString return position string; x=<x>|y=<y>|z=<z>
 */
QString DLDExchangeServerDBusPosition::getNodeInfo (int deviceId)
{
	if (nodeInfo.isEmpty())
		return ("noNodes");
	if (!nodeInfo.contains(deviceId))
		return ("no node information");

	return (QString ("x=%1|y=%2|z=%3").arg(nodeInfo[deviceId].x).arg(nodeInfo[deviceId].y).arg(nodeInfo[deviceId].z));
}
/**
 * @brief slot: updates the strength data of a tag in the internal struct and emits the signal updatedStrength, this slot is used to work in both directions
 * @param deviceId	id of the device whos strength is reported
 * @param tagId		id of the tag whos strength is received
 * @param strength	the strength of the tag
 * @return
 *      void
 */
void DLDExchangeServerDBusPosition::updateStrength (int deviceId, int tagId, double strength)
{
	Q_UNUSED(deviceId)
	Q_UNUSED(tagId)
	Q_UNUSED(strength)
	// do nothing
}
/**
 * @brief sets the maximum axis value
 * @param maximumAxisValue	maximum axis value
 * @return
 *      void
 */
void DLDExchangeServerDBusPosition::setMaximumAxisValue (double maximumAxisValue)
{
	this->maximumAxisValue = maximumAxisValue;
	emit updatedMaximumAxisValue (maximumAxisValue);
}
/**
 * @brief slot: returns the maximum axis value (for the device)
 * @return
 *      int value
 */
double DLDExchangeServerDBusPosition::getMaximumAxisValue ()
{
	return (maximumAxisValue);
}
