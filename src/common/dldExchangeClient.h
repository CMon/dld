/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */
#pragma once

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

	void refreshTagInfos ();
	QList<QString> getTagList();
	StrengthType getStrengths (const QString & tagId);
	TagPositionInformation getPosition (const QString & tagId) const;
	double getMaximumAxisValue ();

	void refreshNodeInfos ();
	QList<QString> getNodeList();
	QVector3D getNodeInformation (const QString & nodeId);

signals:
	void newStrength (const QString & tagId);
	void newNode (const QString & id);
	void newPosition (const QString & tagId);
	void newMaximumAxisValue (double value);

private slots:
	void newNodeInfo (const QString & id, double x, double y, double z);
	void newStrengthInfo (const QString & deviceId, const QString & tagId, double strength);
	void newPositionInfo (const QString & tagId, int timestamp, double x, double y, double z);

private:
	QList<DLDExchangeClientStrategy *> exchangeStrategies;

	QMap<QString, QVector3D> nodeInfo;
	QMap<QString, StrengthType> tagInfo;
	QMap<QString, TagPositionInformation> positionInfo;
	double maximumAxisValue;
};
