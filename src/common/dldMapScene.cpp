 /*
  * dldMap.cpp  - domestic location detection - map class for displaying the scen of a map
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
/** @class DLDMapScene dldMapScene.h
 *
 * @author Simon Schaefer
 *
 * @date 16.03.2008
 *
 * @version 1.0
 * <br>map class for displaying maps in a QGraphicsScene
 */
#include "dldMapScene.h"

/**
 * @brief constructor for DLDMapScene class
 * @param pLog	pointer of the DLDLog object
 * @return
 *      void
 */
DLDMapScene::DLDMapScene (DLDLog * pLog)
	: DLDMap (pLog)
	, tagViewWidth(5)
	, mapXMaximum (0)
	, mapYMaximum (0)
	, helpLineStep (10)
{
}
/**
 * @brief destructor for DLDMapScene class
 * @return
 *      void
 */
DLDMapScene::~DLDMapScene ()
{
	QMapIterator<int, TagItem *> i(tags);
	while (i.hasNext())
	{
		i.next();
		if (i.value())
			delete (i.value());
	}
}
/**
 * @brief create and draw the coordination system
 * @return
 *      void
 */
void DLDMapScene::createCoordSystem ()
{
	for (int i = helpLineStep-((int) mapXMaximum/2); i < (int) mapXMaximum/2; i += helpLineStep)
	{
		if (i != 0)
			addLine (i, -(mapYMaximum/2), i, mapYMaximum/2, QPen(Qt::lightGray));
	}
	for (int i = helpLineStep-((int) mapYMaximum/2); i < (int) mapYMaximum/2; i += helpLineStep)
	{
		if (i != 0)
			addLine (-(mapXMaximum/2), i, mapXMaximum/2, i, QPen(Qt::lightGray));
	}
	addLine (-(mapXMaximum/2), 0, mapXMaximum/2, 0, QPen());
	addLine (0, -(mapYMaximum/2), 0, mapYMaximum/2, QPen());
}
/**
 * @brief slot: add a tag item to internal QMap and scene
 * @param tagId	id of the tag
 * @param color color of the tag
 * @return
 *      void
 */
void DLDMapScene::addTagItem (int tagId, QColor color)
{
	if (tags.contains(tagId))
		return ;
	TagItem * item = new TagItem ();
	item->setBrush (QBrush(color));
	item->setTagId (tagId);
	tags.insert (tagId, item);

	addItem (item);
	connect (item, SIGNAL (mouseEnterTag (int, int, int)), this, SIGNAL (mouseEnterTag (int, int, int)));
	connect (item, SIGNAL (mouseLeaveTag ()), this, SIGNAL (mouseLeaveTag ()));
	connect (item, SIGNAL (mouseMoveOverTag (int, int, int)), this, SIGNAL (mouseMoveOverTag (int, int, int)));
}
/**
 * @brief slot: add a tag item to internal QMap and scene
 * @param tagId	id of the tag
 * @param color color of the tag
 * @return
 *      void
 */
void DLDMapScene::updateTagColor (int tagId, QColor color)
{
	if (tagsOnScene.contains (tagId))
		tags[tagId]->setBrush (QBrush(color));
}
/**
 * @brief slot: set position of an item
 * @param tagId	id of the tag
 * @param pos	new position of the tag/item
 * @return
 *      void
 */
void DLDMapScene::setItemPosition (int tagId, QPointF pos)
{
	if (tags.contains(tagId))
	{
		tags[tagId]->setRect (pos.x()-(tagViewWidth/2.0), pos.y()-(tagViewWidth/2.0), tagViewWidth, tagViewWidth);
		tags[tagId]->setZValue(1); // put the item on top off all the other drawings
	}
}
/**
 * @brief slot: set the size of the map
 * @param value	maximum Axis value in one direction
 * @return
 *      void
 */
void DLDMapScene::setMaximumAxisValue (double value)
{
	mapXMaximum = value * 2.0; // *2 for both directions +-
	mapYMaximum = value * 2.0;
	createCoordSystem ();
}
/**
 * @brief set the diameter of the circle that represents the tag
 * @param width	width of circle
 * @return
 *      void
 */
void DLDMapScene::setTagViewWidth (int width)
{
	tagViewWidth = width;
}
/**
 * @brief return the diameter of the tag circle
 * @return
 *      int	width of circle
 */
int DLDMapScene::getTagViewWidth ()
{
	return (tagViewWidth);
}
/**
 * @brief adds a tag to the tagsOnScene list
 * @param tagId	tag id of the tag that was added
 * @return
 *      void
 */
void DLDMapScene::addTagToScene (int tagId)
{
	tagsOnScene.append (tagId);
}
/**
 * @brief checks if the tag is added to the tagsOnScene list
 * @param tagId	tag id of the tag that was added
 * @return
 *      bool
 */
bool DLDMapScene::isTagOnScene (int tagId)
{
	return (tagsOnScene.contains (tagId));
}
