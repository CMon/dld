!include(../../config.pri):error("base config file (config.pri) not available")

QT += gui

TARGET = MapGen
TEMPLATE = app
DESTDIR = $${BIN_OUT}

FORMS += \
	deviceStrategies/hwSimMainWindow.ui
