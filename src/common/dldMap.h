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

class DLDMap
{
public:
	DLDMap ();
	~DLDMap ();

	void setMapName (const QString & name);
	QString getMapName () const;

	bool loadMap (const QString & path);
	bool saveMap (const QString & path);

	void addZone (DLDZone zone);
	void changeZone (DLDZone zone);
	void removeZone (int id);
	DLDZone getZoneInfo (int id) const;

	void setMapImage (QPixmap image);
	QPixmap getMapImage () const;

	void addNode (int id, QPoint position);
	void removeNode (int id);

private:
	bool writeZoneSpecFile (const QString & path);
	bool readZoneSpecFile (const QString & path);

	QList <DLDZone> zoneInformations;
	QPixmap background;

	QString mapName;
};
