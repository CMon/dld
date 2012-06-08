 /*
  * tagItem.h  - domestic location detection - class for the grahics item regarding a tag
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
#ifndef __TAGITEM_H
#define __TAGITEM_H

#include <QGraphicsEllipseItem>

class QGraphicsSceneHoverEvent;

class TagItem : public QObject, public QGraphicsEllipseItem
{
	Q_OBJECT
	public:
		TagItem ();
		void	setTagId (int id);
		int	getTagId ();

	signals:
		void mouseEnterTag (int tagId, int x, int y);
		void mouseLeaveTag ();
		void mouseMoveOverTag (int tagId, int x, int y);

	protected:
		void hoverEnterEvent (QGraphicsSceneHoverEvent * event);
		void hoverLeaveEvent (QGraphicsSceneHoverEvent * event);
		void hoverMoveEvent (QGraphicsSceneHoverEvent * event);

	private:
		int tagId;
};

#endif
