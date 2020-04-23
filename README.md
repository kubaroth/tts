
# Dependencies
Qt5.14 - As long as QtQuick is compatible with some version Android API
- recommended Android API 21 or higer (Android 5.0)
- tested with Qt5.14 NDK 21.0 Android API 29


# Build dependencies - pdf parser (PDF-Writer)

Update paths to NDK, Android and Qt in:
- build_pdf_hummus_parser.sh
- build_android_package.sh

This will build two sets of libraries for Linux desktop and Android
```
git submodule update --init
./build_pdf_hummus_parser.sh
```

# Build Android apk package and deploy to a phone
(may require checking your device ID with adb (if multiple are connected)
If the phone is connected this should sideload the package
```
./build_android_package.sh
```

# Build Linux desktop package

```
mkdir -p __build_linux && cd __build_linux
$HOME/toolchains/Qt5.14.0/5.14.0/gcc_64/bin/qmake ../tts_android.pro -spec linux-g++ CONFIG+=debug CONFIG+=qml_debug
make -j 4
```

# TODO:
- update license
- ability to load external pdfs
