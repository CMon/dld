/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */
#pragma once

#include <QObject>
#include <QVector3D>

class QString;

/**
 * This class stores the 4 basic information for each device
 */
class DeviceInformation : public QVector3D
{
public:
	DeviceInformation() : id(-1) {}

	bool isValid() const { return id != -1; }

	void fromQVector3D(const QVector3D & other)
	{
		this->setX(other.x());
		this->setY(other.y());
		this->setZ(other.z());
	}

public:
	int	id;
	QString path;
};

/**
 * This is an interface for the used strategy pattern for the dvice handling
 */
class DeviceStrategy : public QObject
{
	Q_OBJECT

public:
	/**
	 * Connects all configured devices (used for starting after adding Devices)
	*/
	virtual void connectDevices () = 0;
	/**
	 * Disconnects all devices, used for closing everything
	*/
	virtual void disconnectDevices () = 0;
	/**
	 * Add a device to the list of devices that should watch for updated informations
	*/
	virtual void addDevice (const QString & path) = 0;
	/**
	 * Removes a device from the collection
	*/
	virtual void removeDevice (const QString & path) = 0;
	/**
	 * prints an example for the configuration
	 */
	void printSampleConfig () const {}
	/**
	 * returns the maximum value of the device on one axis in one direction
	 */
	virtual double getMaximumAxisValue () const = 0;

signals:
	/**
	 * The signal that should be emitted if a receiving device gets a new strength value of a tag
	*/
	void newStrength (const QString & deviceId, QString tagId, double strength);
	/**
	 * The signal that should be emitted when a new receiving device was identified
	 */
	void newNode (const QString & id, double x, double y, double z);
};
