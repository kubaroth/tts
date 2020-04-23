#/bin/bash

export ANDROID_NDK_ROOT=$HOME/Android/Sdk/ndk/21.0.6113669/
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export ANDROID_HOME=$HOME/Android/Sdk
QT_ROOT=$HOME/toolchains/Qt5.14.0/5.14.0
QMAKE=$QT_ROOT/android/bin/qmake

ROOT=$PWD

#git checkout pdf
#git submodule update --init

# build android
mkdir -p __build_hummus_android && cd __build_hummus_android

#TODO: handle hardcoded API version
cmake $ROOT/pdf_hummus_parser \
-DCMAKE_SYSTEM_NAME=Android \
-DCMAKE_SYSTEM_VERSION=29 \
-DCMAKE_ANDROID_ARCH_ABI=armeabi-v7a \
-DCMAKE_ANDROID_NDK=$ANDROID_NDK_ROOT \
-DCMAKE_ANDROID_STL_TYPE=c++_static \
-DCMAKE_INSTALL_PREFIX=$ROOT/__install_android \
-DCMAKE_CXX_FLAGS="-D__ANDROID__"

make -j 4 install
# TODO: move install_android include/ into a separate directory used by all archs 

cd $ROOT/__build_android


$QMAKE $ROOT/tts_android.pro -spec android-clang CONFIG+=debug CONFIG+=qml_debug ANDROID_ABIS=armeabi-v7a

make -j 4 install
cd $ROOT

##### humus linux build

mkdir -p __build_hummus_linux && cd __build_hummus_linux
cmake $ROOT/pdf_hummus_parser -DCMAKE_INSTALL_PREFIX=$ROOT/__install_linux
make -j 4 install
cd $ROOT

