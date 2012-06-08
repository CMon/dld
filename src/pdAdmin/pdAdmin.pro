!include(../../config.pri):error("base config file (config.pri) not available")

QT       += gui sql

TARGET = PDAdmin
TEMPLATE = app

SOURCES += \
	../common/dldLog.cpp \
	dldPdAdmin.cpp \
	main.cpp 

HEADERS  += \
	dldPdAdmin.h

FORMS    += \
	../common/connect2DBDialog.ui \
	mainWindow.ui
