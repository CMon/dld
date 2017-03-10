/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */
#pragma once

#include <QVector3D>

class TagPositionInformation : public QVector3D
{
public:
	void fromQVector3D(const QVector3D & other) {
		this->setX(other.x());
		this->setY(other.y());
		this->setZ(other.z());
	}

	void fromValues(double xpos, double ypos, double zpos) {
		this->setX(xpos);
		this->setY(ypos);
		this->setZ(zpos);
	}

public:
	int	timestamp;
};
