!include(../../config.pri):error("base config file (config.pri) not available")

QT       += gui network

TARGET = GainData
TEMPLATE = app
LIBS += ../../bin/debug/libcommon.so

SOURCES += \
	deviceStrategies/obUSBStrategy.cpp \
	deviceStrategies/dldSimulateStrategy.cpp \
	dldGain.cpp \
        main.cpp \
        deviceStrategies/ddwrtstrategy.cpp

HEADERS  += \
	deviceStrategies/deviceStrategy.h \
	deviceStrategies/obUSBStrategy.h \
	deviceStrategies/dldSimulateStrategy.h \
        dldGain.h \
        deviceStrategies/ddwrtstrategy.h

FORMS    += \
	deviceStrategies/hwSimMainWindow.ui

