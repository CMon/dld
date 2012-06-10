/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */
#pragma once

#include <generatePosition/positionStrategy.h>
#include <common/dldExchangeClient.h>
#include <common/dldExchangeServer.h>
#include <common/tagPositionInformation.h>

#include <QObject>
#include <QSettings>
#include <QMap>

class DLDLog;

class DLDGeneratePosition : public QObject
{
	Q_OBJECT
	public:
		DLDGeneratePosition (int logLevel, QString logFile);
		~DLDGeneratePosition ();

	signals:
		void newTagPos (int tagId, int timestamp, double x, double y, double z);
		void newNodeConnected (int nodeId, double x, double y, double z);

	private slots:
		void newPosition (int tagId);
		void newNode (int nodeId);

	private:
		void					initialPositions ();

		void					readConfiguration ();

		QSettings *				settings;
		DLDDataExchangeServer *			dataExchangeServer;
		DLDDataExchangeClient *			dataExchangeClient;

		DLDLog *				log;
		QMap<int, TagPositionInformation>	tagPositions;
		PositionStrategy *			nodePosition;
		QList<int>				nodeIdList;

// not yet implemented
// 		DLDMap *				mapHandler;
};
