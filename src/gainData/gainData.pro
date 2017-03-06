!include(../../config.pri):error("base config file (config.pri) not available")

QT += gui network

TARGET = GainData
TEMPLATE = app
LIBS += ../../bin/debug/libcommon.so

SOURCES += \
	deviceStrategies/ddwrtstrategy.cpp \
	deviceStrategies/dldSimulateStrategy.cpp \
	deviceStrategies/obUSBStrategy.cpp \
	dldGain.cpp \
	main.cpp \

HEADERS += \
	deviceStrategies/ddwrtstrategy.h \
	deviceStrategies/deviceStrategy.h \
	deviceStrategies/dldSimulateStrategy.h \
	deviceStrategies/obUSBStrategy.h \
	dldGain.h \

FORMS += \
	deviceStrategies/hwSimMainWindow.ui
