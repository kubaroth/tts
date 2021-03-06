QT += quick multimedia
CONFIG += c++11

# gcc a.o -Wl,-Bstatic -lfoo -Wl,-Bdynamic -lbar

ROOT = "$$PWD"
message ("Root Dir: $$ROOT")

linux:!android {
    message("* Using settings for Unix/Linux.")
    
    INCLUDEPATH += $$ROOT/libs/include/
    INCLUDEPATH += $$ROOT/__install_linux/include
    INCLUDEPATH += $$ROOT/pdf_text_extract

    LIBS += -L$$ROOT/libs//static -Wl,--start-group -lcerevoice_pmod -lcerevoice_eng -lcerevoice -lcerehts -Wl,--end-group

    QMAKE_LIBDIR += $$ROOT/__install_linux/lib
    LIBS += -Wl,--start-group -lPDFWriter -lFreeType -lLibAesgm -lLibPng -lLibTiff -lLibJpeg -lZlib -Wl,--end-group

    
    # While testing commenting out copy line will speed up startup
    QMAKE_POST_LINK += $$QMAKE_COPY_FILE $$shell_quote($$PWD/file_data/license_eng.lic) $$shell_quote($$OUT_PWD) $$escape_expand(\\n\\t)
    QMAKE_POST_LINK += $$QMAKE_COPY_FILE $$shell_quote($$PWD/file_data/tts_eng.voice) $$shell_quote($$OUT_PWD) $$escape_expand(\\n\\t)

    # copy test pdf
    QMAKE_POST_LINK += $$QMAKE_COPY_FILE $$shell_quote($$PWD/file_data/curious_character.pdf) $$shell_quote($$OUT_PWD) $$escape_expand(\\n\\t)
}

android {
    message("* Using settings for Android.")
    #### Build for Android arm-v7
    INCLUDEPATH += $$ROOT/libs/include/
    INCLUDEPATH += $$ROOT/__install_android/include
    INCLUDEPATH += $$ROOT/pdf_text_extract
    
    LIBS += -L$$ROOT/libs_android/static -Wl,--start-group -lcerevoice_pmod -lcerevoice_eng -lcerevoice -lcerehts  -Wl,--end-group

    QMAKE_LIBDIR += $$ROOT/__install_android/lib
    LIBS += -Wl,--start-group -lPDFWriter -lFreeType -lLibAesgm -lLibPng -lLibTiff -lLibJpeg -lZlib -Wl,--end-group

    # NOTE: seems like only single deployment/directory can be handled
    deployment.files=file_data/*
    #deployment.files=file_data/license_eng.lic   # used for debugging if the file is copied into the right place
    deployment.path=/assets/tts_data #all assets must go to "/assets" folder of your android package
    INSTALLS += deployment

}


# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

HEADERS += \
    tts.h

SOURCES += \
    main.cpp \
    tts.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH += $$[QT_INSTALL_PREFIX]/qml

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

