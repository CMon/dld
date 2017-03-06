!include(../../config.pri):error("base config file (config.pri) not available")

QT += network widgets

TARGET = GainData
TEMPLATE = app
LIBS += -L$${LIB_OUT} -lcommon
DESTDIR = $${BIN_OUT}

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
