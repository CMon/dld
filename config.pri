DLD_ROOT=$$PWD

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

OBJECTS_DIR  = build/$${DEBUG_OR_RELEASE}
MOC_DIR      = build/gen/moc
UI_DIR       = build/gen/ui
BIN_DIR      = $${DLD_ROOT}/bin/$${DEBUG_OR_RELEASE}
DESTDIR      = $${BIN_DIR}

INCLUDEPATH += $${EXT_INCLUDES} $${DLD_ROOT} build/gen . $${DLD_ROOT}/src
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

QMAKE_DISTCLEAN += $${DLD_ROOT}/libs/debug/*
QMAKE_DISTCLEAN += $${DLD_ROOT}/libs/release/*
QMAKE_DISTCLEAN += $${DLD_ROOT}/bin/debug/*
QMAKE_DISTCLEAN += $${DLD_ROOT}/bin/release/*

