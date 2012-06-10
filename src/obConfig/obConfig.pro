!include(../../config.pri):error("base config file (config.pri) not available")

QT       += gui 

TARGET = OBConfig
TEMPLATE = app
LIBS += ../../bin/debug/libcommon.so

SOURCES += \
	obConfig.cpp \
	main.cpp 

HEADERS  += \
	obConfig.h

FORMS    += \
	mainWindow.ui \
	preferences.ui \
	obConfiguratorHelp.ui \
	aboutOpenBeacon.ui \
	replaceCommandsDialog.ui 

