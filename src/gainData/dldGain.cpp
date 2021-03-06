/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */

/** @class DLDGain dldGain.h
 *
 * @author Simon Schaefer
 *
 * @date 18.02.2008
 *
 * @version 1.0
 * <br> main class for the gain data daemon
 */
#include "dldGain.h"

#include <gainData/deviceStrategies/deviceStrategy.h>
#include <gainData/deviceStrategies/obUSBStrategy.h>
#include <gainData/deviceStrategies/dldSimulateStrategy.h>
#include <common/dldLog.h>

#include <QSettings>
#include <QTextStream>

Q_LOGGING_CATEGORY(GAINDATA, "dld.gainData")

/**
 * @brief constructor for gain data daemon
 * @param strategyToUse the strategy that was chosen through command line
 * @return
 *      void
 */
DLDGain::DLDGain (const QString & strategyToUse)
{
	settings = new QSettings ("DLD", "Gain data daemon");
	qCInfo(GAINDATA) << QString ("Settings will be stored in: %1.").arg (settings->fileName ());

	dataExchangeServer = new DLDDataExchangeServer ();
	dataExchangeServer->addExchangeMethod (DLDDataExchangeServer::TYPE_DBUS, "org.dld.gain", "");

	if (strategyToUse.isEmpty ())
		usedStrategy = settings->value("usedDeviceStrategy", "OpenBeaconUSBStrategy").toString ();
	else
		usedStrategy = strategyToUse;

	DeviceStrategy * device;
	if (usedStrategy == "OpenBeaconUSBStrategy")
		device = new OpenBeaconUSBStrategy ("DLD");
	else // per default use the simulation strategy
		device = new DLDSimulateStrategy ("DLD");
	qCInfo(GAINDATA) << QString ("%1 is the used strategy.").arg (usedStrategy);
	devices.append (device);
	dataExchangeServer->setMaximumAxisValue (device->getMaximumAxisValue ());

	connectDevices (); // connect in the sense of Qt signal slot connect
}
/**
 * @brief destructor for gain data daemon
 * @return
 *      void
 */
DLDGain::~DLDGain ()
{
	settings->setValue("usedDeviceStrategy", usedStrategy);

	if (settings)
	{
		settings->sync ();
		delete (settings);
	}
	if (dataExchangeServer)
		delete (dataExchangeServer);

	for (int i = 0; i < devices.size(); ++i)
	{
		if (devices.at(i))
			delete (devices.at(i));
	}
}
/**
 * @brief connects the device signals to the dataExchange slots
 * @return
 *	void
 */
void DLDGain::connectDevices ()
{
	qCDebug(GAINDATA) << "Connecting devices to the data exchange server.";
	for (int i = 0; i < devices.size(); i++)
	{
		connect(devices.at(i), &DeviceStrategy::newNode,     dataExchangeServer, &DLDDataExchangeServer::updateNodeOnStrategies, Qt::DirectConnection);
		connect(devices.at(i), &DeviceStrategy::newStrength, dataExchangeServer, &DLDDataExchangeServer::updateStrengthOnStrategies, Qt::DirectConnection);
		devices.at(i)->connectDevices ();
	}
}
