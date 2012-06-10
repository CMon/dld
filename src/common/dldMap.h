/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */
#pragma once

#include <QMap>
#include <QPixmap>

#include <common/dldZone.h>

class DLDLog;

class DLDMap
{
	public:
		DLDMap (DLDLog * pLog);
		~DLDMap ();

		void	setMapName (QString name);
		QString getMapName ();

		bool	loadMap (QString path);
		bool	saveMap (QString path);

		void	addZone (DLDZone zone);
		void	changeZone (DLDZone zone);
		void	removeZone (int id);
		DLDZone	getZoneInfo (int id);

		void	setMapImage (QPixmap image);
		QPixmap	getMapImage ();

		void	addNode (int id, QPoint position);
		void	removeNode (int id);
	private:
		bool	writeZoneSpecFile (QString path);
		bool	readZoneSpecFile (QString path);

		DLDLog *		log;

		QList <DLDZone>		zoneInformations;
		QPixmap			background;

		QString			mapName;
};
