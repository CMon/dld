!include(../../config.pri):error("base config file (config.pri) not available")

QT += widgets

TARGET = OBConfig
TEMPLATE = app
LIBS += -L$${LIB_OUT} -lcommon
DESTDIR = $${BIN_OUT}

SOURCES += \
	main.cpp \
	obConfig.cpp \

HEADERS  += \
	obConfig.h

FORMS    += \
	aboutOpenBeacon.ui \
	mainWindow.ui \
	obConfiguratorHelp.ui \
	preferences.ui \
	replaceCommandsDialog.ui \
