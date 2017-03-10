!include(../../config.pri):error("base config file (config.pri) not available")

QT += network dbus xml widgets

TEMPLATE = lib
CONFIG += staticlib
DESTDIR = $${LIB_OUT}

SOURCES += \
	dldExchangeClient.cpp \
	dldExchangeClientDBus.cpp \
	dldExchangeServer.cpp \
	dldExchangeServerDBusPosition.cpp \
	dldExchangeServerDBusStrength.cpp \
	dldLog.cpp \
	dldMap.cpp \
	dldMapScene.cpp \
	obCommunication.cpp \
	tagItem.cpp \

HEADERS  += \
	dldExchangeClient.h \
	dldExchangeClientDBus.h \
	dldExchangeClientStrategy.h \
	dldExchangeServer.h \
	dldExchangeServerDBusPosition.h \
	dldExchangeServerDBusStrength.h \
	dldExchangeServerStrategy.h \
	dldLog.h \
	dldMap.h \
	dldMapScene.h \
	dldZone.h \
	obCommunication.h \
	strengthType.h \
	tagItem.h \
	tagPositionInformation.h \
