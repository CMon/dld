!include(../../config.pri):error("base config file (config.pri) not available")

QT       += gui sql

TARGET = ShowPos
TEMPLATE = app
LIBS += ../../bin/debug/libcommon.so

SOURCES += \
	tagInfoDialog.cpp \
	dldShowPos.cpp \
	main.cpp 

HEADERS  += \
	tagInfoDialog.h \
	tagViewInfos.h \
	dldShowPos.h 

FORMS    += \
	personInfoWidget.ui \
	selectConnectionDialog.ui \
	databaseListDock.ui 

RESOURCES = dldShowPos.qrc

