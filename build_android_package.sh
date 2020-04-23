#/bin/bash

# A script to isntall and app on the phone
# Before running please chech if you have the
# following dependencies :

ANDROID_NDK_ROOT=$HOME/Android/Sdk/ndk/21.0.6113669/
ANDROID_SDK_ROOT=$HOME/Android/Sdk
ANDROID_HOME=$HOME/Android/Sdk
QT_ROOT=$HOME/toolchains/Qt5.14.0/5.14.0
QMAKE=$QT_ROOT/android/bin/qmake

BUILD_ROOT=$PWD

mkdir -p $BUILD_ROOT/__build_android

ADB="$ANDROID_SDK_ROOT/platform-tools/adb"

phone=`$ADB devices | grep -Po "^[0-9a-z]+"`
echo "Device number found: $phone"

# Configure
$QMAKE $BUILD_ROOT/tts_android.pro -spec android-clang CONFIG+=debug CONFIG+=qml_debug ANDROID_ABIS=armeabi-v7a

# Build
make -j4 

rm -rf $BUILD_ROOT/__build_android/assets
rm -rf $BUILD_ROOT/__build_android/libs

# Install
$ANDROID_NDK_ROOT/prebuilt/linux-x86_64/bin/make  INSTALL_ROOT=$BUILD_ROOT/__build_android install

# Push to phone
$QT_ROOT/android/bin/androiddeployqt --verbose --output $BUILD_ROOT/__build_android --no-build --input $BUILD_ROOT/android-tts_android-deployment-settings.json --gradle --reinstall --device $phone
