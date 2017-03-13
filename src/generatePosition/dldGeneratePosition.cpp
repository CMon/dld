/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */
#include "dldGeneratePosition.h"

#include <common/dldExchangeClient.h>
#include <common/dldLog.h>
#include <generatePosition/2dPositionStrategy.h>

#include <QStringList>
#include <time.h>

Q_LOGGING_CATEGORY(GENERATE_POSITION, "dld.generatePosition")

/**
 * @brief constructor for generate position
 */
DLDGeneratePosition::DLDGeneratePosition ()
{
	settings = new QSettings ("DLD", "generate position");
	qCDebug(GENERATE_POSITION) << QString ("Settings will be stored in: %1.").arg (settings->fileName ());

//TODO for after the FYP: do it with a settings file as soon as there are more strategies:
	nodePosition = new TwoDPositionStrategy();

	dataExchangeServer = new DLDDataExchangeServer();
	dataExchangeServer->addExchangeMethod (DLDDataExchangeServer::TYPE_DBUS, "org.dld.genPos", "", DLDDataExchangeServer::DBUS_POSITION);
	connect(this, &DLDGeneratePosition::newTagPos,        dataExchangeServer, &DLDDataExchangeServer::updatePositionOnStrategies);
	connect(this, &DLDGeneratePosition::newNodeConnected, dataExchangeServer, &DLDDataExchangeServer::updateNodeOnStrategies);

	dataExchangeClient = new DLDDataExchangeClient();
	dataExchangeClient->addExchangeMethod (DLDDataExchangeClient::TYPE_DBUS, "org.dld.gain", "", "dld.provide.strength");
	connect(dataExchangeClient, &DLDDataExchangeClient::newStrength,         this,               &DLDGeneratePosition::newPosition);
	connect(dataExchangeClient, &DLDDataExchangeClient::newNode,             this,               &DLDGeneratePosition::newNode);
	connect(dataExchangeClient, &DLDDataExchangeClient::newMaximumAxisValue, dataExchangeServer, &DLDDataExchangeServer::setMaximumAxisValue);

	connect(this, &DLDGeneratePosition::newTagPos,        dataExchangeServer, &DLDDataExchangeServer::updatePositionOnStrategies);
	connect(this, &DLDGeneratePosition::newNodeConnected, dataExchangeServer, &DLDDataExchangeServer::updateNodeOnStrategies);

	dataExchangeServer->setMaximumAxisValue (dataExchangeClient->getMaximumAxisValue());
	initialPositions ();
}
/**
 * @brief destructor for generate position
 */
DLDGeneratePosition::~DLDGeneratePosition ()
{
	qCInfo(GENERATE_POSITION) << "Shutting down generate position daemon";

	settings->sync ();
	if (settings)
		delete (settings);
	if (dataExchangeServer)
		delete (dataExchangeServer);
	if (nodePosition)
		delete (nodePosition);
	if (dataExchangeClient)
		delete (dataExchangeClient);
}
/**
 * @brief adds the currently available nodes and calculates the positions of the currently visibla tags. This method is a startup helper only
 * @return
 *      void
 */
void DLDGeneratePosition::initialPositions ()
{
	foreach (const QString & nodeId, dataExchangeClient->getNodeList()) {
		newNode(nodeId);
	}

	foreach(const QString & tagId, dataExchangeClient->getTagList()) {
		newPosition(tagId);
	}
}
/**
 * @brief slot: position needs an update
 * @param tagId id of the new tag
 * @return
 *      void
 */
void DLDGeneratePosition::newPosition (const QString & tagId)
{
	TagPositionInformation posInfo;
	QVector3D position;
	posInfo.timestamp =  (int) time (NULL);
	QString nodeIds[4];

	// in later development this selection should be made so that the 3(2D) / 4(3D) nodes are chosen by
	// their submitted stregth value, best values win
	if (nodeIdList.size() < 3)
	{
		qCWarning(GENERATE_POSITION) << "Missing node information";
		return;
	} else if (nodeIdList.size() == 3)
	{
		nodeIds[0] = nodeIdList.at(0);
		nodeIds[1] = nodeIdList.at(1);
		nodeIds[2] = nodeIdList.at(2);
		nodeIds[3] = -1;
	} else
	{
		nodeIds[0] = nodeIdList.at(0);
		nodeIds[1] = nodeIdList.at(1);
		nodeIds[2] = nodeIdList.at(2);
		nodeIds[3] = nodeIdList.at(3);
	}

	// in 2d this compares the 0 node circle with the 1 node circle
	bool hadErrors = false;
	position = nodePosition->getPosition (dataExchangeClient->getStrengths (tagId), nodeIds[0], nodeIds[1], nodeIds[2], nodeIds[3], &hadErrors);
	if (hadErrors) {
		// try another constelation
		// in 2d this compares the 0 node circle with the 1 node circle
		position = nodePosition->getPosition (dataExchangeClient->getStrengths (tagId), nodeIds[1], nodeIds[2], nodeIds[0], nodeIds[3], &hadErrors);
		if (hadErrors) {
		// try another constelation
			position = nodePosition->getPosition (dataExchangeClient->getStrengths (tagId), nodeIds[2], nodeIds[0], nodeIds[1], nodeIds[3], &hadErrors);
			if (hadErrors) {
				return ;
			}
		}
	}
	posInfo.fromQVector3D(position);
	tagPositions.insert (tagId, posInfo);
	emit newTagPos (tagId, posInfo.timestamp, posInfo.x(), posInfo.y(), posInfo.z());
	qCInfo(GENERATE_POSITION) << QString("Tag: %1 got a new position: X: %2 Y: %3 Z: %4")
	                              .arg(tagId).arg(posInfo.x()).arg(posInfo.y()).arg(posInfo.z());
}
/**
 * @brief slot: new node was added
 * @param nodeId id of the new node
 * @return
 *      void
 */
void DLDGeneratePosition::newNode (const QString & nodeId)
{
	QVector3D point = dataExchangeClient->getNodeInformation (nodeId);
	nodeIdList.append (nodeId);
	nodePosition->addNode (nodeId, point);
	emit newNodeConnected (nodeId, point.x(), point.y(), point.z());
}
