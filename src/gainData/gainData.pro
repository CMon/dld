!include(../../config.pri):error("base config file (config.pri) not available")

QT       += gui network dbus

TARGET = GainData
TEMPLATE = app

SOURCES += \
	../common/obCommunication.cpp \
	../common/dldExchangeServer.cpp \
	../common/dldExchangeServerDBusStrength.cpp \
	../common/dldExchangeServerDBusPosition.cpp \
	../common/dldLog.cpp \
	deviceStrategies/obUSBStrategy.cpp \
	deviceStrategies/dldSimulateStrategy.cpp \
	dldGain.cpp \
	main.cpp 

HEADERS  += \
	../common/obCommunication.h  \
	../common/dldExchangeServer.h \
	../common/dldExchangeServerStrategy.h \
	../common/dldExchangeServerDBusStrength.h \
	../common/dldExchangeServerDBusPosition.h \
	deviceStrategies/deviceStrategy.h \
	deviceStrategies/obUSBStrategy.h \
	deviceStrategies/dldSimulateStrategy.h \
	dldGain.h

FORMS    += \
	deviceStrategies/hwSimMainWindow.ui

