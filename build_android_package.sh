#/bin/bash

# A script to isntall and app on the phone
# Before running please chech if you have the
# following dependencies :

ANDROID_NDK_ROOT=/home/kuba/Android/Sdk/ndk/21.0.6113669/
ANDROID_SDK_ROOT=/home/kuba/Android/Sdk
ANDROID_HOME=/home/kuba/Android/Sdk
QT_ROOT=/home/kuba/jokkmokk/Qt5.14.0/5.14.0
QMAKE=$QT_ROOT/android/bin/qmake

BUILD_ROOT=$PWD

mkdir $BUILD_ROOT/android-build

ADB="$ANDROID_SDK_ROOT/platform-tools/adb"

phone=`$ADB devices | grep -Po "^[0-9a-z]+"`
echo "Device number found: $phone"

# Configure
$QMAKE $BUILD_ROOT/../tts_android.pro -spec android-clang CONFIG+=debug CONFIG+=qml_debug ANDROID_ABIS=armeabi-v7a

# Build
make -j4 

rm -rf $BUILD_ROOT/android-build/assets
rm -rf $BUILD_ROOT/android-build/libs

# Install
$ANDROID_NDK_ROOT/prebuilt/linux-x86_64/bin/make  INSTALL_ROOT=$BUILD_ROOT/android-build install

# Push to phone
$QT_ROOT/android/bin/androiddeployqt --verbose --output $BUILD_ROOT/android-build --no-build --input $BUILD_ROOT/android-tts_android-deployment-settings.json --gradle --reinstall --device $phone
