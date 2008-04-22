PROJECT ("Domestic location detection - show position")

# 2.4.8 is needed for the QtDBus bindings
CMAKE_MINIMUM_REQUIRED(VERSION 2.4.8 FATAL_ERROR)

# to enable debug cmake must be launched through: "cmake -DDEBUG=1 ."
IF (DEBUG)
	MESSAGE (STATUS "Debug enabled")
	IF (CMAKE_COMPILER_IS_GNUCXX)
		ADD_DEFINITIONS(-g)
	ENDIF (CMAKE_COMPILER_IS_GNUCXX)
ENDIF (DEBUG)

#enable all warnings
ADD_DEFINITIONS (-Wall)

SET (BINARY showPos)

#set minimum qt version
SET (QT_MIN_VERSION "4.3.3")

SET (QT_USE_QTGUI true)
SET (QT_USE_QTNETWORK true)
SET (QT_USE_QTDBUS true)
SET (QT_USE_QTXML true)
SET (QT_USE_QTSQL true)

FIND_PACKAGE(Qt4 REQUIRED)

SET (MOC_HEADERS
	../common/dldExchangeClient.h
	../common/dldExchangeClientStrategy.h
	../common/dldExchangeClientDBus.h
	../common/dldExchangeClientSSL.h
	../common/dldMapScene.h
	../common/tagItem.h
	tagInfoDialog.h
	dldShowPos.h
)

SET (QRC_FILES
	dldShowPos.qrc
)

QT4_WRAP_CPP (MOC_SRC ${MOC_HEADERS})
QT4_ADD_RESOURCES (QRC_SRC ${QRC_FILES})

SET (SRC
	${MOC_SRC}
	${QRC_SRC}
	../common/dldExchangeClient.cpp
	../common/dldExchangeClientDBus.cpp
	../common/dldExchangeClientSSL.cpp
	../common/dldLog.cpp
	../common/dldMap.cpp
	../common/dldMapScene.cpp
	../common/tagItem.cpp
	tagInfoDialog.cpp
	dldShowPos.cpp
	main.cpp
)

SET (UIS
	../common/connect2DBDialog.ui
	personInfoWidget.ui
	selectConnectionDialog.ui
	databaseListDock.ui
)

IF(QT4_FOUND)
	FOREACH (ui ${UIS})
		QT4_WRAP_UI(SRC ${ui})
	ENDFOREACH (ui)
ENDIF(QT4_FOUND)

ADD_EXECUTABLE (${BINARY} ${SRC})

IF (QT4_FOUND)
	INCLUDE_DIRECTORIES (${QT_INCLUDE_DIR})
	INCLUDE_DIRECTORIES (${QT_QT_INCLUDE_DIR})
	INCLUDE_DIRECTORIES (${QT_QTGUI_INCLUDE_DIR})
	INCLUDE_DIRECTORIES (${QT_QTCORE_INCLUDE_DIR})
	INCLUDE_DIRECTORIES (${QT_QTNETWORK_INCLUDE_DIR})
	INCLUDE_DIRECTORIES (${QT_QTDBUS_INCLUDE_DIR})
	INCLUDE_DIRECTORIES (${QT_QTSQL_INCLUDE_DIR})
	INCLUDE_DIRECTORIES (${QT_QTXML_INCLUDE_DIR})
	TARGET_LINK_LIBRARIES (${BINARY}
		${QT_QTGUI_LIBRARY}
		${QT_QTCORE_LIBRARY}
		${QT_QTNETWORK_LIBRARY}
		${QT_QTDBUS_LIBRARY}
		${QT_QTSQL_LIBRARY}
		${QT_QTXML_LIBRARY}
	)
ENDIF (QT4_FOUND)
