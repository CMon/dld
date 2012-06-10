!include(../../config.pri):error("base config file (config.pri) not available")

QT += network dbus xml

CONFIG += qxt
QXT     += core network

TEMPLATE = lib

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
    dldexchangeserverrpc.cpp

HEADERS  += \
	3dPoint.h \
	dldExchangeClientDBus.h \
	dldExchangeClient.h \
	dldExchangeClientStrategy.h \
	dldExchangeServerDBusPosition.h \
	dldExchangeServerDBusStrength.h \
	dldExchangeServer.h \
	dldExchangeServerStrategy.h \
	dldLog.h \
	dldMap.h \
	dldMapScene.h \
	dldZone.h \
	obCommunication.h \
	strengthType.h \
	tagItem.h \
	tagPositionInformation.h \
    dldexchangeserverrpc.h

LIBS += -LQxtCore
INCLUDEPATH += /usr/include/qxt/
