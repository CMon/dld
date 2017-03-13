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

#include <QMap>

class TwoDPositionStrategy : public PositionStrategy
{
public:
	TwoDPositionStrategy ();
	~TwoDPositionStrategy ();

	QVector3D getPosition(const StrengthType & strengths, const QString & aNodeId, const QString & bNodeId,
	                      const QString & cNodeId, const QString & dNodeId, bool * hadErrors) const;

public slots:
	void addNode (const QString & id, const QVector3D & point);

private:
	QMap<QString, QVector3D> nodeInformations;
};
