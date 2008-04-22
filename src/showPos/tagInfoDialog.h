 /*
  * tagInfoDialog.h  - domestic location detection - the tag info dialog
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
#ifndef __TAGINFODIALOG_H
#define __TAGINFODIALOG_H

#include <QDialog>
#include "ui_personInfoWidget.h"
#include "tagViewInfo.h"

class TagInfoDialog  : public QDialog
{
	Q_OBJECT
	public:
		TagInfoDialog (QWidget * par);
		int getXShift ();
		void setInformation (int tagId, TagViewInfo info);

	private:
		Ui::personInfoWidget	personInfoUi;
		int			xShift;
};

#endif
