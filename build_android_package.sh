#/bin/bash

# A script to isntall and app on the phone
# Before running please chech if you have the
# following dependencies :

export ANDROID_NDK_ROOT=$HOME/Android/android-ndk-r21b/
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export ANDROID_HOME=$HOME/Android/Sdk
QT_ROOT=$HOME/toolchains/Qt5.14.0/5.14.0
QMAKE=$QT_ROOT/android/bin/qmake


echo $QMAKE
ROOT=$PWD

mkdir -p __build_android && cd __build_android

ADB="$ANDROID_SDK_ROOT/platform-tools/adb"

phone=`$ADB devices | grep -Po "^[0-9a-z]+"`
echo "Device number found: $phone"

# Configure
$QMAKE $ROOT/tts_android.pro -spec android-clang CONFIG+=debug CONFIG+=qml_debug ANDROID_ABIS=armeabi-v7a

# Build

make -j 4 

rm -rf __build_android/assets
rm -rf __build_android/libs

# Install
$ANDROID_NDK_ROOT/prebuilt/linux-x86_64/bin/make  INSTALL_ROOT=$ROOT/__build_android install

# Push to phone
$QT_ROOT/android/bin/androiddeployqt --verbose --output $ROOT/__build_android --no-build --input android-tts_android-deployment-settings.json --gradle --reinstall --device $phone
