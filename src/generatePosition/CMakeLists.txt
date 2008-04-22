PROJECT ("domestic location detection - generate position")
ADD_DEFINITIONS(-D_POSITION)

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

SET (BINARY genPos)

#set minimum qt version
SET (QT_MIN_VERSION "4.3.3")

SET (QT_DONT_USE_QTGUI true)
SET (QT_USE_QTNETWORK true)
SET (QT_USE_QTDBUS true)

FIND_PACKAGE(Qt4 REQUIRED)

SET (MOC_HEADERS
	../common/dldExchangeClient.h
	../common/dldExchangeClientStrategy.h
	../common/dldExchangeClientDBus.h
	../common/dldExchangeClientSSL.h
	../common/dldExchangeServer.h
	../common/dldExchangeServerStrategy.h
	../common/dldExchangeServerDBusPosition.h
	../common/dldExchangeServerDBusStrength.h
	../common/dldExchangeServerSSL.h
	dldGeneratePosition.h
	positionStrategy.h
)
QT4_WRAP_CPP (MOC_SRC ${MOC_HEADERS})

SET (SRC
	${MOC_SRC}
	../common/dldExchangeClient.cpp
	../common/dldExchangeClientDBus.cpp
	../common/dldExchangeClientSSL.cpp
	../common/dldExchangeServer.cpp
	../common/dldExchangeServerDBusPosition.cpp
	../common/dldExchangeServerDBusStrength.cpp
	../common/dldExchangeServerSSL.cpp
	../common/dldLog.cpp
	2dPositionStrategy.cpp
	dldGeneratePosition.cpp
	main.cpp
)

ADD_EXECUTABLE (${BINARY} ${SRC})

IF (QT4_FOUND)
	INCLUDE_DIRECTORIES (${QT_INCLUDE_DIR})
	INCLUDE_DIRECTORIES (${QT_QT_INCLUDE_DIR})
	INCLUDE_DIRECTORIES (${QT_QTCORE_INCLUDE_DIR})
	INCLUDE_DIRECTORIES (${QT_QTNETWORK_INCLUDE_DIR})
	INCLUDE_DIRECTORIES (${QT_QTDBUS_INCLUDE_DIR})
	TARGET_LINK_LIBRARIES (${BINARY}
		${QT_QTCORE_LIBRARY}
		${QT_QTNETWORK_LIBRARY}
		${QT_QTDBUS_LIBRARY}
	)
ENDIF (QT4_FOUND)
