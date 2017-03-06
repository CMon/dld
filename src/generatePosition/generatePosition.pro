!include(../../config.pri):error("base config file (config.pri) not available")

QT += widgets dbus

TARGET = GeneratePosition
TEMPLATE = app
LIBS += -L$${LIB_OUT} -lcommon
DESTDIR = $${BIN_OUT}

SOURCES += \
	2dPositionStrategy.cpp \
	dldGeneratePosition.cpp \
	main.cpp \

HEADERS  += \
	2dPositionStrategy.h \
	dldGeneratePosition.h \
	positionStrategy.h \
