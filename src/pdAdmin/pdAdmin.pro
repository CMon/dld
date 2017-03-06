!include(../../config.pri):error("base config file (config.pri) not available")

QT += widgets sql

TARGET = PDAdmin
TEMPLATE = app
LIBS += -L$${LIB_OUT} -lcommon
DESTDIR = $${BIN_OUT}

SOURCES += \
	dldPdAdmin.cpp \
	main.cpp \

HEADERS  += \
	dldPdAdmin.h \

FORMS += \
	../common/connect2DBDialog.ui \
	mainWindow.ui \
