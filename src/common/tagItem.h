/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */
#pragma once

#include <QGraphicsEllipseItem>

class QGraphicsSceneHoverEvent;

class TagItem : public QObject, public QGraphicsEllipseItem
{
	Q_OBJECT

public:
	TagItem ();
	void setTagId (int id);
	int getTagId () const;

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
