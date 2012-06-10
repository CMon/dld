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

/**
 * @brief constructor for generate position
 * @param logLevel the logLevel which should be used for the application
 * @param logFile the file where the logging should end
 * @return
 *      void
 */
DLDGeneratePosition::DLDGeneratePosition (int logLevel, QString logFile)
{
	log = new DLDLog ();
	log->setLogLevel (logLevel);
	if (!logFile.isEmpty())
		log->setLogFile (logFile);

	settings = new QSettings ("DLD", "generate position");
	log->infoLog (QString ("Settings will be stored in: %1.").arg (settings->fileName ()));

//TODO for after the FYP: do it with a settings file as soon as there are more strategies:
	nodePosition = new TwoDPositionStrategy (log);

	dataExchangeServer = new DLDDataExchangeServer (log);
	dataExchangeServer->addExchangeMethod (DLDDataExchangeServer::TYPE_DBUS, "org.dld.genPos", "", DLDDataExchangeServer::DBUS_POSITION);
	connect (this, SIGNAL(newTagPos (int, int, double, double, double)), dataExchangeServer, SLOT(updatePositionOnStrategies (int, int, double, double, double)));
	connect (this, SIGNAL(newNodeConnected (int, double, double, double)), dataExchangeServer, SLOT(updateNodeOnStrategies (int, double, double, double)));

	dataExchangeClient = new DLDDataExchangeClient (log);
	dataExchangeClient->addExchangeMethod (DLDDataExchangeClient::TYPE_DBUS, "org.dld.gain", "", "dld.provide.strength");
	connect (dataExchangeClient, SIGNAL(newStrength (int)), this, SLOT(newPosition (int)));
	connect (dataExchangeClient, SIGNAL(newNode (int)), this, SLOT(newNode (int)));
	connect (dataExchangeClient, SIGNAL(newMaximumAxisValue (double)), dataExchangeServer, SLOT(setMaximumAxisValue (double)));

	connect (this, SIGNAL(newTagPos (int, int, double, double, double)), dataExchangeServer, SLOT(updatePositionOnStrategies (int, int, double, double, double)));
	connect (this, SIGNAL(newNodeConnected (int, double, double, double)), dataExchangeServer, SLOT(updateNodeOnStrategies (int, double, double, double)));

	dataExchangeServer->setMaximumAxisValue (dataExchangeClient->getMaximumAxisValue());
	initialPositions ();
}
/**
 * @brief destructor for generate position
 * @return
 *      void
 */
DLDGeneratePosition::~DLDGeneratePosition ()
{
	log->infoLog ("Shutting down generate position daemon");

	settings->sync ();
	if (log)
		delete (log);
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
	QList<int> nodes = dataExchangeClient->getNodeList ();
	for (int i = 0; i < nodes.size(); i++)
	{
		newNode (nodes.at(i));
	}

	QList<int> tags = dataExchangeClient->getTagList ();
	for (int i = 0; i < tags.size(); i++)
	{
		newPosition (tags.at(i));
	}
}
/**
 * @brief slot: position needs an update
 * @param tagId id of the new tag
 * @return
 *      void
 */
void DLDGeneratePosition::newPosition (int tagId)
{
	TagPositionInformation	posInfo;
	ThreeDPoint * position;
	posInfo.timestamp =  (int) time (NULL);
	int	nodeIds[4];

	// in later development this selection should be made so that the 3(2D) / 4(3D) nodes are chosen by
	// their submitted stregth value, best values win
	if (nodeIdList.size() < 3)
	{
		log->errorLog ("Missing node information");
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
	position = nodePosition->getPosition (dataExchangeClient->getStrengths (tagId), nodeIds[0], nodeIds[1], nodeIds[2], nodeIds[3]);
	if (!position)
	{
		// try another constelation
		// in 2d this compares the 0 node circle with the 1 node circle
		position = nodePosition->getPosition (dataExchangeClient->getStrengths (tagId), nodeIds[1], nodeIds[2], nodeIds[0], nodeIds[3]);
		if (!position)
		{
		// try another constelation
			position = nodePosition->getPosition (dataExchangeClient->getStrengths (tagId), nodeIds[2], nodeIds[0], nodeIds[1], nodeIds[3]);
			if (!position)
			{
				return ;
			}
		}
	}
	posInfo.x = position->x;
	posInfo.y = position->y;
	posInfo.z = position->z;
	tagPositions.insert (tagId, posInfo);
	emit newTagPos (tagId, posInfo.timestamp, posInfo.x, posInfo.y, posInfo.z);
	log->infoLog (QString("Tag: %1 got a new position: X: %2 Y: %3 Z: %4")
			.arg(tagId).arg(posInfo.x).arg(posInfo.y).arg(posInfo.z));
	if (position)
		delete (position);
}
/**
 * @brief slot: new node was added
 * @param nodeId id of the new node
 * @return
 *      void
 */
void DLDGeneratePosition::newNode (int nodeId)
{
	ThreeDPoint	point = dataExchangeClient->getNodeInformation (nodeId);
	nodeIdList.append (nodeId);
	nodePosition->addNode (nodeId, point);
	emit newNodeConnected (nodeId, point.x, point.y, point.z);
}
