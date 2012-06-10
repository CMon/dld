/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */

/** @class OpenBeaconCommunication obCommunication.h
 *
 * @author Simon Schaefer
 *
 * @date 09.02.2008
 *
 * @version 1.0
 * <br> Class for communication with the OpenBeacon devices
 */
#include "obCommunication.h"

#include <common/dldLog.h>

#include <QFile>
#include <QThread>
#include <QQueue>
#include <QMutex>

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <termios.h>
#include <unistd.h>

/**
 * @brief constructor for OpenBeacon communication
 * @return
 *      void
 */
OpenBeaconCommunication::OpenBeaconCommunication (DLDLog * pLog)
{
	log = pLog;
	device = 0;
	readRunning = true;
	sendQueue.clear ();
}
/**
 * @brief destructor for OpenBeacon communication
 * @return
 *      void
 */
OpenBeaconCommunication::~OpenBeaconCommunication ()
{
	stop ();
	closeDevice ();
}
/**
 * @brief setup the device and start the communication thread
 * @return
 *      int	0 if all is ok, -1 if devicePath is empty, -2 if the device does not exist, -3 if open fails
 */
int OpenBeaconCommunication::startCommunication ()
{
	struct termios newtio;

	stop ();
	if (devicePath.isEmpty ())
		return (-1);

	if (device)
		closeDevice ();

	fileDescriptor = open ( devicePath.toLatin1(), O_RDWR | O_NOCTTY | O_NONBLOCK );
	if (fileDescriptor < 0)
		return (-2);

	bzero(&newtio, sizeof(newtio));
        // setting control modes -> man 3 termios
	newtio.c_cflag = B115200 | CRTSCTS | CS8 | CLOCAL | CREAD;
        // setting input modes -> man 3 termios
	newtio.c_iflag = IGNPAR | ICRNL;
        // setting output modes -> man 3 termios
	newtio.c_oflag = 0;
        // canonical input
	newtio.c_lflag = ICANON;
        // initialize all control characters
	newtio.c_cc[VTIME] = 0; // inter-character timer unused
	newtio.c_cc[VMIN] = 2;  // blocking read until 1 character arrives
        // clean the line and set the new settings
	tcflush(fileDescriptor, TCIFLUSH);
	tcsetattr(fileDescriptor,TCSANOW,&newtio);

	device = new QFile (devicePath);

	if (!device->exists ())
	{
		log->errorLog (QString ("Device does not exist: %1").arg (devicePath));
		return (-2);
	}

// 	if (!device->open (QIODevice::ReadWrite | QIODevice::Text | QIODevice::Truncate)) // | QIODevice::Unbuffered
	if (!device->open (fileDescriptor, QIODevice::ReadWrite | QIODevice::Text))
	{
		log->errorLog (QString ("Could not open device: %1").arg (devicePath));
		return (-3);
	}

	readRunning = true;
	start (LowPriority);
	return (0);
}
/**
 * @brief run function of the thread, reads all the stuff from the device and puts it in the receive queue. If send queue has somthing it will be send.
 * @return
 *      void
 */
void OpenBeaconCommunication::run ()
{
	log->debugLog (QString ("Thread for device %1 started").arg(devicePath));
	while (readRunning)
	{
		QString line = device->readLine ();
		if (!line.isEmpty() && line != "\n")
		{
			line = line.trimmed ();
			emit newData (line);
			log->debugLog (QString ("OB Received: %1").arg(line));
		}
		if (!sendQueue.isEmpty ())
		{
			sendQueueMutex.lock ();
			QString command = sendQueue.dequeue();
			sendQueueMutex.unlock ();

			command.append ("\r");
			log->debugLog (QString ("OB sending command: %1").arg(command));
			if ( device->write (command.toLatin1()) == -1)
			{
				emit writeFailed ();
				log->debugLog (QString ("OB sending failed."));
			}
		}

		usleep (100); // sleep a little bit to not gain 100% CPU
	}
}
/**
 * @brief close the OpenBeacon device
 * @return
 *      void
 */
void OpenBeaconCommunication::closeDevice ()
{
	log->debugLog (QString("Closing device %1.").arg(devicePath));
	if (device)
	{
		if (device->isOpen())
			device->close ();
		delete (device);
		device = 0;
	}
	if (fileDescriptor)
		close (fileDescriptor);
}
/**
 * @brief stops the running process
 * @return
 *      void
 */
void OpenBeaconCommunication::stop ()
{
	sendQueueMutex.lock ();
	sendQueue.clear();
	sendQueueMutex.unlock ();
	readRunning = false;
	terminate ();
	wait();
}
/**
 * @brief sends the command to the OpenBeacon
 * @param command	the command that should be send to the OpenBeacon
 * @return
 *      void
 */
void OpenBeaconCommunication::sendToOB (QString command)
{
	sendQueueMutex.lock ();
	sendQueue.enqueue(command);
	sendQueueMutex.unlock ();
	log->debugLog (QString ("OB Command received to send: %1").arg(command));
}
/**
 * @brief returns the current device path
 * @return
 *      QString	path
 */
QString OpenBeaconCommunication::getDevicePath ()
{
	return (devicePath);
}
/**
 * @brief sets the device path
 * @param path	the device that should be used for OB
 * @return
 *      void
 */
void OpenBeaconCommunication::setDevicePath (QString path)
{
	devicePath = path;
}
