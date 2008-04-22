PROJECT ("Domestic location detection - Open Beacon Configurator")

# to enable debug cmake must be launched through: "cmake -DDEBUG=1 ."
IF (DEBUG)
	MESSAGE (STATUS "Debug enabled")
	IF (CMAKE_COMPILER_IS_GNUCXX)
		ADD_DEFINITIONS(-g)
	ENDIF (CMAKE_COMPILER_IS_GNUCXX)
ENDIF (DEBUG)

#enable all warnings
ADD_DEFINITIONS (-Wall)

SET (BINARY obConfig)

#set minimum qt version
SET (QT_MIN_VERSION "4.3.3")

FIND_PACKAGE(Qt4 REQUIRED)

SET (MOC_HEADERS
	obConfig.h
	../common/obCommunication.h
)

QT4_WRAP_CPP            (MOC_SRC ${MOC_HEADERS})

SET (SRC
	${MOC_SRC}
	../common/dldLog.cpp
	../common/obCommunication.cpp
	obConfig.cpp
	main.cpp
)

SET (UIS
	mainWindow.ui
	preferences.ui
	obConfiguratorHelp.ui
	aboutOpenBeacon.ui
	replaceCommandsDialog.ui
)

IF(QT4_FOUND)
	FOREACH (ui ${UIS})
		QT4_WRAP_UI(SRC ${ui})
	ENDFOREACH (ui)
ENDIF(QT4_FOUND)

ADD_EXECUTABLE (${BINARY} ${SRC})

IF(QT4_FOUND)
	INCLUDE_DIRECTORIES(${QT_INCLUDE_DIR})
	INCLUDE_DIRECTORIES(${QT_QT_INCLUDE_DIR})
	INCLUDE_DIRECTORIES(${QT_QTCORE_INCLUDE_DIR})
	INCLUDE_DIRECTORIES(${QT_QTGUI_INCLUDE_DIR})
	TARGET_LINK_LIBRARIES(${BINARY}
		${QT_QTGUI_LIBRARY}
		${QT_QTCORE_LIBRARY}
	)
ENDIF(QT4_FOUND)
