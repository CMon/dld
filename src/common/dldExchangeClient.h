/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */
#pragma once

#include <common/3dPoint.h>
#include <common/dldExchangeClientStrategy.h>
#include <common/tagPositionInformation.h>

class DLDDataExchangeClient : public QObject
{
Q_OBJECT
public:
	DLDDataExchangeClient ();
	~DLDDataExchangeClient ();

	void addExchangeMethod (int type, QString basePath, QString subPath, QString interface);
	// class defines:
	static const int TYPE_DBUS  = 1;

	void                   refreshTagInfos ();
	QList<int>             getTagList ();
	StrengthType           getStrengths (int tagId);
	TagPositionInformation getPosition (int tagId);
	double                 getMaximumAxisValue ();

	void        refreshNodeInfos ();
	QList<int>  getNodeList ();
	ThreeDPoint getNodeInformation (int nodeId);

signals:
	void newStrength (int tagId);
	void newNode (int id);
	void newPosition (int tagId);
	void newMaximumAxisValue (double value);

private slots:
	void newNodeInfo (int id, double x, double y, double z);
	void newStrengthInfo (int deviceId, int tagId, double strength);
	void newPositionInfo (int tagId, int timestamp, double x, double y, double z);

private:
	QList<DLDExchangeClientStrategy *> exchangeStrategies;

	QMap<int, ThreeDPoint>            nodeInfo;
	QMap<int, StrengthType>           tagInfo;
	QMap<int, TagPositionInformation> positionInfo;
	double                            maximumAxisValue;
};
