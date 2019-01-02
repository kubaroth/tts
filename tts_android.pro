QT += quick
CONFIG += c++11


LIBS += -L/home/kuba/SRC/TTS/sdk_4.0.4_linux_x86_64_python27/cerevoice_eng/lib
LIBS += -L/home/kuba/SRC/TTS/sdk_4.0.4_linux_x86_64_python27/cerevoice/lib
LIBS += -L/home/kuba/SRC/TTS/sdk_4.0.4_linux_x86_64_python27/cerevoice_pmod/lib
LIBS += -L/home/kuba/SRC/TTS/sdk_4.0.4_linux_x86_64_python27/cerevoice_aud/lib
LIBS += -L/home/kuba/SRC/TTS/sdk_4.0.4_linux_x86_64_python27/cerehts/lib
#LIBS += $$BUILD/../libs
LIBS += -lcerevoice_aud_shared -lcerevoice_eng_shared -lcerevoice_pmod_shared -lcerehts_shared -lcerevoice_shared -lstdc++ -lutil -ldl -lm -lrt
#LIBS += -L/home/kuba/PRJ/cpp_rozne/tts_tests/libs/libcerehts.a -L/home/kuba/PRJ/cpp_rozne/tts_tests/libs/libcerevoice.a -L/home/kuba/PRJ/cpp_rozne/tts_tests/libs/libcerevoice_aud.a -L/home/kuba/PRJ/cpp_rozne/tts_tests/libs/libcerevoice_eng.a -L/home/kuba/PRJ/cpp_rozne/tts_tests/libs/libcerevoice_pmod.a

INCLUDEPATH += /home/kuba/SRC/TTS/sdk_4.0.4_linux_x86_64_python27/cerevoice_eng/include
INCLUDEPATH += /home/kuba/SRC/TTS/sdk_4.0.4_linux_x86_64_python27/cerevoice_aud/include
QMAKE_LFLAGS += "-Wl,-rpath,\'\$$ORIGIN/../libs'"

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        main.cpp \
    tts.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    tts.h
