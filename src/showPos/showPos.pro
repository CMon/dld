!include(../../config.pri):error("base config file (config.pri) not available")

QT += widgets sql dbus

TARGET = ShowPos
TEMPLATE = app
LIBS += -L$${LIB_OUT} -lcommon
DESTDIR = $${BIN_OUT}

SOURCES += \
	dldShowPos.cpp \
	main.cpp \
	tagInfoDialog.cpp \

HEADERS  += \
	dldShowPos.h \
	tagInfoDialog.h \
	tagViewInfo.h \

FORMS    += \
	../common/connect2DBDialog.ui \
	databaseListDock.ui \
	personInfoWidget.ui \
	selectConnectionDialog.ui \

RESOURCES = \
	dldShowPos.qrc \
