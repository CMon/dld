/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */
#pragma once

#include <common/strengthType.h>

#include <QObject>
#include <QMap>

class QString;

class DLDExchangeClientStrategy : public QObject
{
	Q_OBJECT
public:
	/**
	 * std. destructor
	*/
	~DLDExchangeClientStrategy() {}
	/**
	 * retrieve the tag list from the data exchange server
	*/
	virtual QString getTagList () const = 0;
	/**
	 * retrieve the node list from the data exchange server
	*/
	virtual QString getNodeList () const = 0;
	/**
	 * retrieve the tags strength string from the data exchange server
	*/
	virtual QString getStrengths (const QString & tagId) const = 0;
	/**
	 * retrieve the node information string from the data exchange server
	*/
	virtual QString getNodeInfo (const QString & deviceId) const = 0;
	/**
	 * Get the maximum axis value of the used device
	 */
	virtual double getMaximumAxisValue () const = 0;

signals:
	/**
	 * send when new strength information arrives at the client side of the dbus
	*/
	void newStrength (const QString & deviceId, const QString & tagId, double strength);
	/**
	 * send when new node information arrives at the client side of the dbus
	 */
	void newNode (const QString & nodeId, double x, double y, double z);
};
