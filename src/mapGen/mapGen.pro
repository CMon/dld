!include(../../config.pri):error("base config file (config.pri) not available")

QT += gui

TARGET = MapGen
TEMPLATE = app

FORMS += \
	deviceStrategies/hwSimMainWindow.ui
