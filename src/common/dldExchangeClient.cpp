/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */

/** @class DLDDataExchangeClient dldExchangeClient.h
 *
 * @author Simon Schaefer
 *
 * @date 24.02.2008
 *
 * @version 1.0
 * <br> Class for the DLD exchange client class
 */

#include <common/dldExchangeClient.h>
#include <common/dldExchangeClientDBus.h>
#include <common/dldExchangeClientStrategy.h>
#include <common/dldLog.h>

#include <QMap>

Q_LOGGING_CATEGORY(EXCHANGE_CLIENT, "dld.exchangeClient")


/**
 * @brief constructor for DLDDataExchangeClient class
 */
DLDDataExchangeClient::DLDDataExchangeClient ()
	: maximumAxisValue (0)
{
}
/**
 * @brief destructor for DLDDataExchangeClient class
 * @return
 *      void
 */
DLDDataExchangeClient::~DLDDataExchangeClient ()
{
	nodeInfo.clear ();
	tagInfo.clear ();
	for (int i = 0; i < exchangeStrategies.size(); i++)
	{
		if (exchangeStrategies.at(i))
			delete (exchangeStrategies.at(i));
	}
}
/**
 * @brief adds another Exchange Method to the List
 * @param type Either TYPE_DBUS or ...
 * @param basePath The base path on tcp connections its the host + port, on D-Bus its the URI
 * @param subPath the sub path (used for the dBus strategy
 * @return
 *      void
 */
void DLDDataExchangeClient::addExchangeMethod (int type, const QString & basePath, const QString & subPath, const QString & interface)
{
	DLDExchangeClientStrategy *	newMethod;
	switch (type)
	{
		case TYPE_DBUS:
			newMethod = new DLDExchangeClientDBus (basePath, subPath, interface);
			break;
		default:
			// do nothing if the programmer chosed the wrong type.
			return;
	}
	exchangeStrategies.append (newMethod);

	connect(newMethod, &DLDExchangeClientStrategy::newStrength, this, &DLDDataExchangeClient::newStrengthInfo, Qt::DirectConnection);
	connect(newMethod, &DLDExchangeClientStrategy::newNode, this,     &DLDDataExchangeClient::newNodeInfo,     Qt::DirectConnection);
}
/**
 * @brief slot: adds the new node information to the local storage, if it differs from previous entries
 * @param id id of the node
 * @param x x position of the node
 * @param y y position of the node
 * @param z z position of the node
 * @return
 *      void
 */
void DLDDataExchangeClient::newNodeInfo (const QString & id, double x, double y, double z)
{
	nodeInfo.insert (id, QVector3D(x, y, z));
	emit newNode (id);
}
/**
 * @brief slot: adds the new strength information to the local storage, if it differs from previous entries
 * @param deviceId id of the node
 * @param tagId id of the tag
 * @param strength strength that the node received for the tag
 * @return
 *      void
 */
void DLDDataExchangeClient::newStrengthInfo (const QString & deviceId, const QString & tagId, double strength)
{
	StrengthType str;
	str.insert (deviceId, strength);
	tagInfo.insert (tagId, str);
	emit newStrength (tagId);
}
/**
 * @brief slot: adds the new strength information to the local storage, if it differs from previous entries
 * @param tagId id of the tag
 * @param timestamp timestamp of the position
 * @param x x position
 * @param y y position
 * @param z z position
 * @return
 *      void
 */
void DLDDataExchangeClient::newPositionInfo (const QString & tagId, int timestamp, double x, double y, double z)
{
	TagPositionInformation	info;
	info.timestamp = timestamp;
	info.fromQVector3D(QVector3D(x, y, z));
	positionInfo.insert (tagId, info);
	emit newPosition (tagId);
}
/**
 * @brief returns the strength information for the tag
 * @param tagId id of the tag
 * @return
 *      StrengthType the strength map of the tag id
 */
StrengthType DLDDataExchangeClient::getStrengths (const QString & tagId)
{
	refreshTagInfos ();
	return (tagInfo[tagId]);
}
/**
 * @brief returns a list of the tags
 * @return
 *      QList<QString>  a list with tag ids
 */
QList<QString> DLDDataExchangeClient::getTagList ()
{
	refreshTagInfos ();
	return tagInfo.keys();
}
/**
 * @brief returns a list of the nodes
 * @return
 *      QList<QString>  a list with node ids
 */
QList<QString> DLDDataExchangeClient::getNodeList ()
{
	refreshNodeInfos ();

	if (nodeInfo.isEmpty()) {
		qCDebug(EXCHANGE_CLIENT) << "No nodes in list.";
	}
	return nodeInfo.keys();
}
/**
 * @brief returns the position of the node
 * @param nodeId the id of the node
 * @return
 *      ThreeDPoint the node list
 */
QVector3D DLDDataExchangeClient::getNodeInformation(const QString & nodeId)
{
	refreshNodeInfos ();
	return (nodeInfo[nodeId]);
}
/**
 * @brief refresh the internal tag informations from all the clients
 * @return
 *      void
 */
void DLDDataExchangeClient::refreshTagInfos ()
{
	foreach (const DLDExchangeClientStrategy * strategy, exchangeStrategies) {
		if (!strategy) continue;

		const QString tags = strategy->getTagList();
		if (tags != "noTags")
		{
			// tag1|tag2|tag3|...
			const QStringList tagList = tags.split("|", QString::SkipEmptyParts);
			foreach (const QString & tagId, tagList) {
				StrengthType str;
				// node1=str1|node2=str2|...
				const QStringList infos = strategy->getStrengths (tagId).split("|", QString::SkipEmptyParts);
				foreach (const QString & info, infos) {
					str.insert (info.split("=").at(0), info.split("=").at(1).toDouble ());
				}
				tagInfo.insert (tagId, str);
			}
		}
	}
}
/**
 * @brief refresh the internal node informations from all the clients
 * @return
 *      void
 */
void DLDDataExchangeClient::refreshNodeInfos ()
{
	for (int i = 0; i < exchangeStrategies.size(); i++)
	{
		if (exchangeStrategies.at(i))
		{
			QString nodes = exchangeStrategies.at(i)->getNodeList ();
			if (nodes != "noNodes")
			{
				QStringList nodeList = nodes.split("|", QString::SkipEmptyParts);
				for (int j = 0; j < nodeList.size (); j++)
				{
					QVector3D point;
					const QString id = nodeList.at(j);
					QStringList coords = exchangeStrategies.at(i)->getNodeInfo (id).split("|", QString::SkipEmptyParts);
					for (int k = 0; k < coords.size(); k++)
					{
						if (coords.at(k).startsWith("x="))
							point.setX(coords.at(k).split("=").at(1).toDouble ());
						else if (coords.at(k).startsWith("y="))
							point.setY(coords.at(k).split("=").at(1).toDouble ());
						else if (coords.at(k).startsWith("z="))
							point.setZ(coords.at(k).split("=").at(1).toDouble ());
					}
					nodeInfo.insert (id, point);
				}
			}
		}
	}
}
/**
 * @brief returns the tag position information of the tag
 * @param tagId	the id of the tag
 * @return
 *      TagPositionInformation the requested informations
 */
TagPositionInformation DLDDataExchangeClient::getPosition (const QString & tagId) const
{
	return (positionInfo[tagId]);
}
/**
 * @brief returns the maximum axis value
 * @return
 *      int maximum axis value
 */
double DLDDataExchangeClient::getMaximumAxisValue ()
{
	for (int i = 0; i < exchangeStrategies.size(); i++)
	{
		if (exchangeStrategies.at(i))
		{
			maximumAxisValue = qMax (maximumAxisValue, exchangeStrategies.at(i)->getMaximumAxisValue ());
		}
	}
	return (maximumAxisValue);
}
