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

	void addTagToScene (const QString & tagId);
	bool isTagOnScene (const QString & tagId) const;

	void setTagViewWidth (int width);
	int getTagViewWidth () const;

	void updateTagColor (const QString & tagId, const QColor & color);

signals:
	void mouseEnterTag (const QString & tagId, int x, int y);
	void mouseLeaveTag ();
	void mouseMoveOverTag (const QString & tagId, int x, int y);

public slots:
	void addTagItem (const QString & tagId, const QColor & color);
	void setItemPosition (const QString & tagId, const QPointF & pos);
	void setMaximumAxisValue (double value);

private:
	void createCoordSystem ();

	QList <QString> tagsOnScene;
	QMap <QString, TagItem *> tags;

	int tagViewWidth;
	double mapXMaximum;
	double mapYMaximum;
	int helpLineStep;
};
