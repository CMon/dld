CONFIG += c++11

exists($${DLD_ROOT}/local.pri) {
    include($${DLD_ROOT}/local.pri)
}

CONFIG(debug, debug|release)|CONFIG(DebugBuild) {
    CONFIG -= debug release
    CONFIG += debug
    DEBUG_OR_RELEASE = debug
} else {
    CONFIG -= debug release
    CONFIG += release
    DEBUG_OR_RELEASE = release
    DEFINES += NDEBUG
}

CONFIG -= warn_off
CONFIG += warn_on

LIB_OUT      = $${DLD_OUT}/lib
BIN_OUT      = $${DLD_OUT}/bin

INCLUDEPATH += $${EXT_INCLUDES} $${DLD_ROOT} $${OBJECTS_DIR} $${MOC_DIR} $${UI_DIR} . $${DLD_ROOT}/src
DEPENDPATH  += $${DLD_ROOT}
win32 {
    QMAKE_CXXFLAGS += /Gy /GR /nologo
    QMAKE_CXXFLAGS += /wd4275 /wd4251 /wd4996 # disable several warnings globally
    QMAKE_CXXFLAGS += /Fdqmake.pdb

    # The UNICODE uses multi-byte characters functions. We cannot use this!
    DEFINES -= UNICODE
    DEFINES += _WIN32_WINNT=0x0501 WIN32 NOMINMAX
} else {
    QMAKE_CXXFLAGS += -Wall -Wno-non-virtual-dtor
}

QMAKE_LIBDIR += $${LIB_DIR} $${EXT_LIB_DIR}

QMAKE_DISTCLEAN += $${DLD_OUT}/libs/debug/*
QMAKE_DISTCLEAN += $${DLD_OUT}/libs/release/*
QMAKE_DISTCLEAN += $${DLD_OUT}/bin/debug/*
QMAKE_DISTCLEAN += $${DLD_OUT}/bin/release/*
