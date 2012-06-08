!include(../../config.pri):error("base config file (config.pri) not available")

QT       += gui network dbus

TARGET = GeneratePosition
TEMPLATE = app

SOURCES += \
	../common/dldExchangeClient.cpp \
	../common/dldExchangeClientDBus.cpp \
	../common/dldExchangeClientSSL.cpp \
	../common/dldExchangeServer.cpp \
	../common/dldExchangeServerDBusPosition.cpp \
	../common/dldExchangeServerDBusStrength.cpp \
	../common/dldExchangeServerSSL.cpp \
	../common/dldLog.cpp \
	2dPositionStrategy.cpp \
	dldGeneratePosition.cpp \
	main.cpp 

HEADERS  += \
	../common/dldExchangeClient.h \
	../common/dldExchangeClientStrategy.h \
	../common/dldExchangeClientDBus.h \
	../common/dldExchangeClientSSL.h \
	../common/dldExchangeServer.h \
	../common/dldExchangeServerStrategy.h \
	../common/dldExchangeServerDBusPosition.h \
	../common/dldExchangeServerDBusStrength.h \
	../common/dldExchangeServerSSL.h \
	dldGeneratePosition.h \
	positionStrategy.h 

