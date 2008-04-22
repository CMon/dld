 /*
  * tagItem.cpp  - domestic location detection - class for the grahics item regarding a tag
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
/** @class TagItem tagItem.h
 *
 * @author Simon Schaefer
 *
 * @date 16.03.2008
 *
 * @version 1.0
 * <br>class for the grahics item regarding a tag
 */
#include "tagItem.h"

#include <QGraphicsSceneHoverEvent>

/**
 * @brief constructor for TagItem class
 * @return
 *      void
 */
TagItem::TagItem ()
{
	setAcceptHoverEvents ( true );
}
/**
 * @brief set the tagId
 * @param id	the tag id to be set
 * @return
 *      void
 */
void TagItem::setTagId (int id)
{
	tagId = id;
}
/**
 * @brief returns the tag id
 * @return
 *      int	tag id
 */
int TagItem::getTagId ()
{
	return (tagId);
}
/**
 * @brief overloaded event method, emits a signal regarding the event
 * @return
 *      void
 */
void TagItem::hoverEnterEvent (QGraphicsSceneHoverEvent * event)
{
	emit mouseEnterTag (tagId, event->screenPos ().x(), event->screenPos ().y());
}
/**
 * @brief overloaded event method, emits a signal regarding the event
 * @return
 *      void
 */
void TagItem::hoverMoveEvent (QGraphicsSceneHoverEvent * event)
{
	emit mouseMoveOverTag (tagId, event->screenPos ().x(), event->screenPos ().y());
}
/**
 * @brief overloaded event method, emits a signal regarding the event
 * @return
 *      void
 */
void TagItem::hoverLeaveEvent (QGraphicsSceneHoverEvent * event)
{
	emit mouseLeaveTag ();
}
