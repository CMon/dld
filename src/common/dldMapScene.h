/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */
#pragma once

#include <QGraphicsScene>

#include <common/dldMap.h>
#include <common/tagItem.h>

class QColor;

class DLDMapScene : public QGraphicsScene, public DLDMap
{
	Q_OBJECT
public:
	DLDMapScene ();
	~DLDMapScene ();

	void addTagToScene (int tagId);
	bool isTagOnScene (int tagId);

	void setTagViewWidth (int width);
	int getTagViewWidth ();

	void updateTagColor (int tagId, QColor color);

signals:
	void mouseEnterTag (int tagId, int x, int y);
	void mouseLeaveTag ();
	void mouseMoveOverTag (int tagId, int x, int y);

public slots:
	void addTagItem (int tagId, QColor color);
	void setItemPosition (int tagId, QPointF pos);
	void setMaximumAxisValue (double value);

private:
	void createCoordSystem ();

	QList <int> tagsOnScene;
	QMap <int, TagItem *> tags;

	int tagViewWidth;
	double mapXMaximum;
	double mapYMaximum;
	int helpLineStep;
};
