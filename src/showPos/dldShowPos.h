/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <simon.schaefer@koeln.de> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Simon Schäfer
 * ----------------------------------------------------------------------------
 */
#pragma once

#include <common/dldExchangeClient.h>
#include <showPos/tagInfoDialog.h>
#include <showPos/tagViewInfo.h>

#include <QDialog>
#include <QGraphicsScene>
#include <QMainWindow>
#include <QtSql>

#include "ui_connect2DBDialog.h"
#include "ui_databaseListDock.h"
#include "ui_personInfoWidget.h"

class QAction;
class QMenu;
class QTabWidget;
class QSettings;
class QDockWidget;
class QDoubleSpinBox;
class DLDMapScene;

class DLDShowPos : public QMainWindow
{
Q_OBJECT
public:
	DLDShowPos ();
	~DLDShowPos ();
	virtual bool eventFilter( QObject * object, QEvent * event);

signals:
	void connectedToGenPos (bool state);
	void connectedToDatabase (bool state);
	void newDataNeeded (int tagId);

protected:
	void closeEvent(QCloseEvent *event);

private slots:
	void loadMap ();
	void connectToGenPos ();
	void about();
	void disconnectFromGenPos ();

	void connectDialog ();
	void disconnectFromDB ();
	void refreshEntries ();
	void getNewData (int tagId);

	void showPersonInfo ();
	void showDatabaseListDock ();
	void zoom (double zoomBy);

	void mouseEnterTag (int tagId, int x, int y);
	void mouseLeaveTag ();
	void mouseMoveOverTag (int tagId, int x, int y);

	void updatePosition (int tagId);
	void newNode (int nodeId);

private:
	static const int CONN_NONE  = 0;
	static const int CONN_DBUS  = 2;

	QSettings *	settings;

	void createActions ();
	void createMenus ();
	void createToolBars ();
	void createStatusBar ();
	void createDocks ();

	void readSettings ();
	void writeSettings ();

	void connectToDbus ();

	void fillPersonInfoDock (int tagId, TagViewInfo info);

	void addNodeInfo (int nodeId, QPointF position);
	void addTagItem (int tagId);
	void updatePosition (int tagId, double x, double y);
	bool connectToDB (QString type, QString host, int port, QString dbName, QString username, QString password);

	int			currentConnectionType;

	QMenu *			fileMenu;
	QMenu *			showMenu;
	QMenu *			helpMenu;

	QToolBar *		toolBar;

	QLabel *		zoomLabel;
	QDoubleSpinBox *	zoomSpin;

	QAction *		loadMapAct;
	QAction *		connectToGenPosAct;
	QAction *		disconnectFromGenPosAct;
	QAction *		connectToDBAct;
	QAction *		disconnectFromDBAct;

	QAction *		showPersonInfoAct;
	QAction *		showPersonInfoHintAct;
	QAction *		showDatabaseListDockAct;

	QAction *		exitAct;
	QAction *		aboutAct;
	QAction *		aboutQtAct;

	QGraphicsView *		mapView;
	DLDMapScene *		mapScene;
	QDockWidget *		personInfoDock;

	Ui::personInfoWidget	personInfoUi;
	TagInfoDialog *		tagInfoDialog;

	DLDDataExchangeClient *	exchangeClient;

	QMap <int, TagViewInfo>	tags;

	Ui::connect2DBDialog	connect2DBDialogUi;
	Ui::databaseListDock	databaseListDockUi;
	QSqlDatabase		database;
	QDockWidget *		databaseListDock;
	QString			personsTable;

	QMap <int, QPixmap>	pictureMap;
};
