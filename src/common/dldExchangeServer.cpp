/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */
/** @class DLDExchangeServer dldExchangeServer.h
 *
 * @author Simon Schaefer
 *
 * @date 18.02.2008
 *
 * @version 1.0
 * <br> Class for the DLD server exchange strategies (controler)
 */
#include <common/dldExchangeServer.h>
#include <common/dldExchangeServerDBusStrength.h>
#include <common/dldExchangeServerDBusPosition.h>
#include <common/dldExchangeServerStrategy.h>
#include <common/dldLog.h>

#include <QString>
#include <QList>
#include <QVariant>

/**
 * @brief constructor for DLDDataExchange class
 */
DLDDataExchangeServer::DLDDataExchangeServer ()
{
}

/**
 * @brief destructor for DLDDataExchange class
 * @return
 *      void
 */
DLDDataExchangeServer::~DLDDataExchangeServer ()
{
	for (int i = 0; i < exchangeStrategies.size(); ++i) {
		if (exchangeStrategies.at(i)) delete (exchangeStrategies.at(i));
	}
}

/**
 * @brief adds another Exchange Method to the List
 * @param type Adding the given type as exchange method
 * @param basePath The base path on tcp connection its the host + port, on D-Bus its the URI
 * @param subPath the sub path (used for the dBus strategy
 * @return
 *      void
 */
void DLDDataExchangeServer::addExchangeMethod (int type, const QString & basePath, const QString & subPath, int dBusType)
{
	DLDExchangeServerStrategy *	newMethod;
	switch (type)
	{
		case TYPE_DBUS:
			switch (dBusType)
			{
				case DBUS_POSITION:
					newMethod = new DLDExchangeServerDBusPosition (basePath, subPath);
					break;
				default: // is strength
					newMethod = new DLDExchangeServerDBusStrength (basePath, subPath);
			}
			break;
		default:
			// do nothing if the programmer chosed the wrong type.
			return;
	}
	exchangeStrategies.append (newMethod);
}

/**
 * @brief slot: informs all strategies about the new node data
 * @param id	id of the node
 * @param x	x position of the node
 * @param y	y position of the node
 * @param z	z position of the node
 * @return
 *      void
 */
void DLDDataExchangeServer::updateNodeOnStrategies (const QString & id, double x, double y, double z)
{
	for (int i = 0; i < exchangeStrategies.size(); i++) {
		exchangeStrategies.at(i)->updateNode (id, x, y, z);
	}
}

/**
 * @brief slot: informs all strategies about the new position data
 * @param tagId		id of the tag
 * @param timeStamp	timestamp of the position arrival
 * @param x		x position of the tag
 * @param y		y position of the tag
 * @param z		z position of the tag
 * @return
 *      void
 */
void DLDDataExchangeServer::updatePositionOnStrategies (const QString & tagId, int timestamp, double x, double y, double z)
{
	for (int i = 0; i < exchangeStrategies.size(); i++) {
		exchangeStrategies.at(i)->updatePosition (tagId, timestamp, x, y, z);
	}
}

/**
 * @brief slot: informs all strategies about the new strength data
 * @param deviceId	id of the node
 * @param tagId		id of the tag
 * @param strength	strength of the tag
 * @return
 *      void
 */
void DLDDataExchangeServer::updateStrengthOnStrategies (const QString & deviceId, const QString & tagId, double strength)
{
	for (int i = 0; i < exchangeStrategies.size(); i++) {
		exchangeStrategies.at(i)->updateStrength (deviceId, tagId, strength);
	}
}

/**
 * @brief informs all strategies about the maximum axis value
 * @param maximumAxisValue	maximum axis value
 * @return
 *      void
 */
void DLDDataExchangeServer::setMaximumAxisValue (double maximumAxisValue)
{
	for (int i = 0; i < exchangeStrategies.size(); i++) {
		exchangeStrategies.at(i)->setMaximumAxisValue (maximumAxisValue);
	}
}
