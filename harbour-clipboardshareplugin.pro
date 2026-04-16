TEMPLATE = lib
TARGET = $$qtLibraryTarget(clipboardshareplugin)
CONFIG += plugin

CONFIG += link_pkgconfig
PKGCONFIG += nemotransferengine-qt5

HEADERS += src/clipboardplugininfo.h \
    src/clipboardmediatransfer.h \
    src/clipboardtransferiface.h

SOURCES += src/clipboardplugininfo.cpp \
    src/clipboardmediatransfer.cpp \
    src/clipboardtransferiface.cpp

OTHER_FILES += qml/ClipboardShareUi.qml \
    rpm/harbour-clipboardshareplugin.spec \
    rpm/harbour-clipboardshareplugin.changes

qml.path = /usr/share/nemo-transferengine/plugins
qml.files = qml/ClipboardShareUi.qml

target.path = $$LIBDIR/nemo-transferengine/plugins/sharing
INSTALLS += target qml
