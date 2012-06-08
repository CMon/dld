 /*
  * dldMap.cpp  - domestic location detection - map class for loading and viewing
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
/** @class DLDMap dldMap.h
 *
 * @author Simon Schaefer
 *
 * @date 16.03.2008
 *
 * @version 1.0
 * <br>map class for loading/saving and viewing
 */
#include <QColor>
#include <QMap>
#include <QtXml>

#include "dldMap.h"
#include "dldLog.h"

/**
 * @brief constructor for DLDMap class
 * @param pLog	pointer of the DLDLog object
 * @return
 *      void
 */
DLDMap::DLDMap (DLDLog * pLog)
	: log (pLog)
	, mapName ("Unnamed Map")
{
}
/**
 * @brief destructor for DLDMap class
 * @return
 *      void
 */
DLDMap::~DLDMap ()
{
}
/**
 * @brief adds the zone to the zoneInformation list
 * @param zone	the zone that should be added
 * @return
 *      bool
 */
void DLDMap::addZone (DLDZone zone)
{
	changeZone (zone);
}
/**
 * @brief changes the zone in the zoneInformation list, if not in list then it got added
 * @param zone	the zone that should be changed
 * @return
 *      bool
 */
void DLDMap::changeZone (DLDZone zone)
{
	// check if zone already exists:
	for (int i = 0; i < zoneInformations.size(); ++i)
	{
		if (zoneInformations.at(i).id == zone.id)
		{
			zoneInformations.replace (i, zone);
			return;
		}
	}
	// if it comes so far it does not exist so simply add
	zoneInformations.append (zone);
}
/**
 * @brief removes the zone from the zoneInformation list
 * @param id	the id of the zone that should be removed
 * @return
 *      bool
 */
void DLDMap::removeZone (int id)
{
	for (int i = 0; i < zoneInformations.size(); ++i)
	{
		if (zoneInformations.at(i).id == id)
		{
			zoneInformations.removeAt (i);
			return;
		}
	}
}
/**
 * @brief returns the zone information of the requested zone
 * @param id	id of the zone
 * @return
 *      DLDZone	the zone information
 */
DLDZone DLDMap::getZoneInfo (int id)
{
	for (int i = 0; i < zoneInformations.size(); ++i)
	{
		if (zoneInformations.at(i).id == id)
		{
			return (zoneInformations.at (i));
		}
	}
	DLDZone failedZone;
	failedZone.id = -1;
	return (failedZone);
}
/**
 * @brief sets the background image
 * @param image	background image
 * @return
 *      void
 */
void DLDMap::setMapImage (QPixmap image)
{
	background = image;
}
/**
 * @brief returns the background image
 * @return
 *      QPixmap	the background image
 */
QPixmap DLDMap::getMapImage ()
{
	return (background);
}
/**
 * @brief set the map name
 * @param name	map name
 * @return
 *      void
 */
void DLDMap::setMapName (QString name)
{
	mapName = name;
}
/**
 * @brief returns the map name
 * @return
 *      QString	the map name
 */
QString DLDMap::getMapName ()
{
	return (mapName);
}
/**
 * @brief writes the zone specification file
 * @param path	the path were the specification file should be stored
 * @return
 *      bool
 */
bool DLDMap::writeZoneSpecFile (QString path)
{
	QFile specFile (path + mapName + ".xml");
	if (!specFile.open (QIODevice::WriteOnly | QIODevice::Text))
	{
		log->errorLog (QString ("Could not open file: %1.").arg (path + mapName + ".xml"));
		return (false);
	}
	QTextStream out (&specFile);

	out << "<Map>" << endl;
	out << "\t<Name>" << mapName << "</Name>" << endl;
	for (int i = 0; i < zoneInformations.size(); ++i)
	{
		out << "\t<Zone id=" << zoneInformations.at(i).id << " name=\"" << zoneInformations.at(i).name << "\" ";
		out << "color=" << zoneInformations.at(i).color.name () << ">" << endl;
		for (int j = 0; j < zoneInformations.at(i).boundings.size (); j++)
		{
			out << "\t\t<Point x=" << zoneInformations.at (i).boundings.point (j).x () << " y=";
			out << zoneInformations.at(i).boundings.point (j).y () << "></Point>" << endl;
		}
		out << "\t</Zone>" << endl;
	}

	out << "</Map>" << endl;

	specFile.close ();
	return (true);
}
/**
 * @brief read the zone specification file
 * @param path	the path were the specification file can be found
 * @return
 *      bool
 */
bool DLDMap::readZoneSpecFile (QString path)
{
	QFile specFile (path + mapName + ".xml");
	if (!specFile.open (QIODevice::ReadOnly | QIODevice::Text))
	{
		log->errorLog (QString ("Could not open file: %1.").arg (path + mapName + ".xml"));
		return (false);
	}

	specFile.close ();
	return (true);
}
/**
 * @brief load a map
 * @param path	the path were the map should be loaded from
 * @return
 *      bool
 */
bool DLDMap::loadMap (QString path)
{
	background = QPixmap (path + mapName + ".png");
	readZoneSpecFile (path);
	return (false);
}
/**
 * @brief save the map
 * @param path	the path were the map should be saved
 * @return
 *      bool
 */
bool DLDMap::saveMap (QString path)
{
	writeZoneSpecFile (path);
	background.save (path + mapName + ".png");
	return (false);
}
// void DLDMap::addNode (int id, QPoint position);
// void DLDMap::removeNode (int id);
