 /*
  * obCommunication.h  - domestic location detection - OpenBeacon Communication
  *
  * Copyright (c) by Simon Schäfer <Simon.Schaefer@koeln.de>
  *
  * *************************************************************************
  * *                                                                       *
  * * This program is free software; you can redistribute it and/or modify  *
  * * it under the terms of the GNU General Public License as published by  *
  * * the Free Software Foundation; either version 2 of the License, or     *
  * * (at your option) any later version.                                   *
  * *                                                                       *
  * *************************************************************************
 */
#ifndef __OBCOMMUNICATION_H
#define __OBCOMMUNICATION_H

#include <QFile>
#include <QThread>
#include <QQueue>
#include <QMutex>

class QString;
class DLDLog;

class OpenBeaconCommunication : public QThread
{
	Q_OBJECT
	public:
		OpenBeaconCommunication (DLDLog * pLog);
		~OpenBeaconCommunication ();

		int	startCommunication ();
		void	stop ();

		void	closeDevice ();
		void	changeDevice ();

		QString	getDevicePath ();
		void	setDevicePath (QString path);

	public slots:
		void	sendToOB (QString command);

	signals:
		void	newData (QString line);
		void	writeFailed ();

	protected:
		void	run ();

	private:

		bool		readRunning;
		QQueue<QString>	sendQueue;
		QMutex		sendQueueMutex;

		int 		fileDescriptor;
		QString		devicePath;
		QFile *		device;
		DLDLog *	log;
};

#endif
