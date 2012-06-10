!include(../../config.pri):error("base config file (config.pri) not available")

QT       += gui sql

TARGET = PDAdmin
TEMPLATE = app
LIBS += ../../bin/debug/libcommon.so

SOURCES += \
	dldPdAdmin.cpp \
	main.cpp 

HEADERS  += \
	dldPdAdmin.h

FORMS    += \
	mainWindow.ui
