!include(../../config.pri):error("base config file (config.pri) not available")

QT += gui

TARGET = OBConfig
TEMPLATE = app
LIBS += ../../bin/debug/libcommon.so

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
