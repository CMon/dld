!include(../../config.pri):error("base config file (config.pri) not available")

QT       += gui 

TARGET = OBConfig
TEMPLATE = app

SOURCES += \
	../common/dldLog.cpp \
	../common/obCommunication.cpp \
	obConfig.cpp \
	main.cpp 

HEADERS  += \
	obConfig.h \
	../common/obCommunication.h 

FORMS    += \
	mainWindow.ui \
	preferences.ui \
	obConfiguratorHelp.ui \
	aboutOpenBeacon.ui \
	replaceCommandsDialog.ui 

