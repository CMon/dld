 /*
  * dldZone.h  - domestic location detection - this class stores zone related data
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
#ifndef __DLDZONE_H
#define __DLDZONE_H

#include <QPolygon>

class QColor;
class QString;

class DLDZone
{
	public:
		int		id;
		QColor		color;
		QString		name;
		QPolygon	boundings;
};

#endif
