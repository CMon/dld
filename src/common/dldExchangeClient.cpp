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
void DLDDataExchangeClient::addExchangeMethod (int type, QString basePath, QString subPath, QString interface)
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

	connect (newMethod, SIGNAL(newStrength (int, int, double)), this, SLOT(newStrengthInfo (int, int, double)), Qt::DirectConnection );
	connect (newMethod, SIGNAL(newNode (int, double, double, double)), this, SLOT(newNodeInfo (int, double, double, double)), Qt::DirectConnection );
	connect (newMethod, SIGNAL(newPosition (int, int, double, double, double)), this, SLOT(newPositionInfo (int, int, double, double, double)), Qt::DirectConnection );
	connect (newMethod, SIGNAL(newMaximumAxisValue (double)), this, SIGNAL(newMaximumAxisValue (double)), Qt::DirectConnection );
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
void DLDDataExchangeClient::newNodeInfo (int id, double x, double y, double z)
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
void DLDDataExchangeClient::newStrengthInfo (int deviceId, int tagId, double strength)
{
	StrengthType	str;
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
void DLDDataExchangeClient::newPositionInfo (int tagId, int timestamp, double x, double y, double z)
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
StrengthType DLDDataExchangeClient::getStrengths (int tagId)
{
	refreshTagInfos ();
	return (tagInfo[tagId]);
}
/**
 * @brief returns a list of the tags
 * @return
 *      QList<int> the tag list
 */
QList<int> DLDDataExchangeClient::getTagList ()
{
	refreshTagInfos ();
	QList<int>	rtList;
	QMapIterator<int, StrengthType>	i(tagInfo);
	rtList.clear ();

	while (i.hasNext())
	{
		i.next();
		rtList.append(i.key());
	}
	return (rtList);
}
/**
 * @brief returns a list of the nodes
 * @return
 *      QList<int> the node list
 */
QList<int> DLDDataExchangeClient::getNodeList ()
{
	refreshNodeInfos ();
	QList<int>			rtList;
	rtList.clear ();
	if (nodeInfo.isEmpty())
	{
		qCDebug(EXCHANGE_CLIENT) << "No nodes in list.";
		return (rtList);
	}
	QMapIterator<int, QVector3D> i(nodeInfo);
	while (i.hasNext())
	{
		i.next();
		rtList.append(i.key());
	}
	return (rtList);
}
/**
 * @brief returns the position of the node
 * @param nodeId the id of the node
 * @return
 *      ThreeDPoint the node list
 */
QVector3D DLDDataExchangeClient::getNodeInformation(int nodeId)
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
	int id;
	for (int i = 0; i < exchangeStrategies.size(); i++)
	{
		if (exchangeStrategies.at(i))
		{
			QString tags = exchangeStrategies.at(i)->getTagList ();
			if (tags != "noTags")
			{
				// tag1|tag2|tag3|...
				QStringList tagList = tags.split("|", QString::SkipEmptyParts);
				for (int j = 0; j < tagList.size (); j++)
				{
					StrengthType str;
					id = tagList.at(j).toInt();
					// node1=str1|node2=str2|...
					QStringList infos = exchangeStrategies.at(i)->getStrengths (id).split("|", QString::SkipEmptyParts);
					for (int k = 0; k < infos.size(); k++)
					{
						str.insert (infos.at(k).split("=").at(0).toInt(), infos.at(k).split("=").at(1).toDouble ());
					}
					tagInfo.insert (id, str);
				}
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
	int id;
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
					id = nodeList.at(j).toInt();
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
TagPositionInformation DLDDataExchangeClient::getPosition (int tagId)
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
