/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */
#pragma once

#include <QFile>
#include <QThread>
#include <QQueue>
#include <QMutex>

class QString;

class OpenBeaconCommunication : public QThread
{
	Q_OBJECT
	public:
		OpenBeaconCommunication ();
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
};
