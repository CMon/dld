/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */
#pragma once

class QString;

/**
 * This is an interface for the exchange strategies
*/
class DLDExchangeServerStrategy
{
public:
	/**
	 * std. destructor
	 */
	virtual ~DLDExchangeServerStrategy (){}
	/**
	 * Used to update the node data
	*/
	virtual void updateNode (const QString & id, double x, double y, double z) = 0;
	/**
	 * Used to update the tag position data
	 */
	virtual void updatePosition (const QString & tagId, int timestamp, double x, double y, double z) = 0;
	/**
	 * Used to update the tag strength data
	 */
	virtual void updateStrength (const QString & deviceId, const QString & tagId, double strength) = 0;
	/**
	 * Set the maximum axis value of the device strategy
	*/
	virtual void setMaximumAxisValue (double maximumAxisValue) = 0;
};
