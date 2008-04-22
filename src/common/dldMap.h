 /*
  * dldMap.h  -  domestic location detection - map class for loading and viewing
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
#ifndef __DLDMAP_H
#define __DLDMAP_H

#include <QMap>
#include <QPixmap>

#include "dldZone.h"

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

#endif
