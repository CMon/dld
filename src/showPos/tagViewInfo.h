 /*
  * tagViewInfo.h  - domestic location detection - helper class for all the infos of a tag
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
#ifndef __TAGVIEWINFO_H
#define __TAGVIEWINFO_H

class TagViewInfo
{
	public:
		int		lastSeen;
		QPixmap		image;
		QString		name;
		QString 	prename;
		QColor		color;
		QPointF		position;
		QString		description;
};

#endif
