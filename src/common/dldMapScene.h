 /*
  * dldMapScene.h  -  domestic location detection - map class for displaying the scen of a map
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
#ifndef __DLDMAPSCENE_H
#define __DLDMAPSCENE_H

#include <QGraphicsScene>

#include "../common/dldMap.h"
#include "tagItem.h"

class DLDLog;
class QColor;

class DLDMapScene : public QGraphicsScene, public DLDMap
{
	Q_OBJECT
	public:
		DLDMapScene (DLDLog * pLog);
		~DLDMapScene ();

		void	addTagToScene (int tagId);
		bool	isTagOnScene (int tagId);

		void	setTagViewWidth (int width);
		int	getTagViewWidth ();

		void	updateTagColor (int tagId, QColor color);

	signals:
		void	mouseEnterTag (int tagId, int x, int y);
		void	mouseLeaveTag ();
		void	mouseMoveOverTag (int tagId, int x, int y);

	public slots:
		void	addTagItem (int tagId, QColor color);
		void	setItemPosition (int tagId, QPointF pos);
		void	setMaximumAxisValue (double value);

	private:
		void			createCoordSystem ();

		DLDLog *		log;
		QList <int>		tagsOnScene;
		QMap <int, TagItem *>	tags;

		int			tagViewWidth;
		double			mapXMaximum;
		double			mapYMaximum;
		int			helpLineStep;
};

#endif
