/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */
#pragma once

#include <showPos/tagViewInfo.h>

#include <QDialog>

#include "ui_personInfoWidget.h"

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

