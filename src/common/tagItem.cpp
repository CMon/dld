/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
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
