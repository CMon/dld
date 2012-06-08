!include(../../config.pri):error("base config file (config.pri) not available")

QT       += gui sql xml dbus network

TARGET = ShowPos
TEMPLATE = app

SOURCES += \
	../common/dldExchangeClient.cpp \
	../common/dldExchangeClientDBus.cpp \
	../common/dldLog.cpp \
	../common/dldMap.cpp \
	../common/dldMapScene.cpp \
	../common/tagItem.cpp \
	tagInfoDialog.cpp \
	dldShowPos.cpp \
	main.cpp 

HEADERS  += \
	../common/dldExchangeClient.h \
	../common/dldExchangeClientStrategy.h \
	../common/dldExchangeClientDBus.h \
	../common/dldMapScene.h \
	../common/tagItem.h \
	tagInfoDialog.h \
	dldShowPos.h 

FORMS    += \
	../common/connect2DBDialog.ui \
	personInfoWidget.ui \
	selectConnectionDialog.ui \
	databaseListDock.ui 

RESOURCES = dldShowPos.qrc

