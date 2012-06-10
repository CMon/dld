!include(../../config.pri):error("base config file (config.pri) not available")

QT       += gui

TARGET = GeneratePosition
TEMPLATE = app
LIBS += ../../bin/debug/libcommon.so

SOURCES += \
	2dPositionStrategy.cpp \
	dldGeneratePosition.cpp \
	main.cpp 

HEADERS  += \
	dldGeneratePosition.h \
	positionStrategy.h 
