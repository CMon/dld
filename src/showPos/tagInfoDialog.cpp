/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */
/** @class TagInfoDialog tagInfoDialog.h
 *
 * @author Simon Schaefer
 *
 * @date 16.03.2008
 *
 * @version 1.0
 * <br>Helperclass for the show position application class. used to display the mouseover dialog
 */
#include "tagInfoDialog.h"

#include <QDateTime>

/**
 * @brief constructor for TagInfoDialog class
 * @param par	parent widget
 * @return
 *      void
 */
TagInfoDialog::TagInfoDialog (QWidget * par)
	: QDialog(par, (Qt::Popup | Qt::FramelessWindowHint | Qt::Tool | Qt::X11BypassWindowManagerHint))
		, xShift(15)
{
	QWidget *	personInfoWidget = new QWidget;
	personInfoUi.setupUi (personInfoWidget);
	QVBoxLayout * layout = new QVBoxLayout ();
	layout->addWidget (personInfoWidget);
	setLayout (layout);
	resize (280, 280);
}
/**
 * @brief returns the x shift, used to display the dialog next to the mouse not under it (prevents flickering)
 * @return
 *      void
 */
int TagInfoDialog::getXShift () const
{
	return (xShift);
}
/**
 * @brief sets the information of the dialog
 * @param tagId	id of the tag
 * @param info	the informations of the tag
 * @return
 *      void
 */
void TagInfoDialog::setInformation (int tagId, TagViewInfo info)
{
	QDateTime time;
	time.setTime_t (info.lastSeen);

	personInfoUi.nameEdit->setText (info.name);
	personInfoUi.prenameEdit->setText (info.prename);
	personInfoUi.lastSeenEdit->setText (time.toString("hh:mm:ss ap"));
	personInfoUi.tagIdEdit->setText (QString ("%1").arg(tagId));
	personInfoUi.pictureLabel->setPixmap (info.image.scaled (personInfoUi.pictureLabel->size (), Qt::KeepAspectRatio));
	personInfoUi.colorEdit->setText (info.color.name ());
	personInfoUi.descriptionEdit->setText (info.description);
}
