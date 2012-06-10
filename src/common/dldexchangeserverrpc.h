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
#include <common/dldExchangeServerStrategy.h>
#include <common/dldLog.h>
#include <common/strengthType.h>
#include <common/tagPositionInformation.h>

#include <QMap>
#include <QObject>
#include <QxtRPCService>

class DLDExchangeServerRPC : public QObject, public DLDExchangeServerStrategy
{
	Q_OBJECT
public:
	explicit DLDExchangeServerRPC(QObject *parent = 0);
	void setMaximumAxisValue (double maximumAxisValue);

	void init ();
//public slots:
//	QString getTagList ();
//	QString getNodeList ();
//	QString getStrengths (int tagId);
//	QString getNodeInfo (int deviceId);
//	double getMaximumAxisValue ();

signals:
	void updatedNode (int id, double x, double y, double z);
	void updatedMaximumAxisValue (double value);
	void updatedPosition (int tagId, int timestamp, double x, double y, double z);
	void updatedStrength (int deviceId, int tagId, double strength);

private slots:
	void updateNode (int id, double x, double y, double z);
	void updatePosition (int tagId, int timestamp, double x, double y, double z);
	void updateStrength (int deviceId, int tagId, double strength);

private:
	QxtRPCService  rpcService;

private:
	DLDLog *                          log;

	QMap<int, ThreeDPoint>            nodeInfo;
	QMap<int, TagPositionInformation> tagPosition;
	QMap<int, StrengthType>           tagInfo;

	double                            maximumAxisValue;
};
