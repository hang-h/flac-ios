#!/bin/bash

ARCH="armv7"
IOSMV="-miphoneos-version-min=7.0"

OGG_DIR=`pwd`
OGG_DIR="${OGG_DIR}/../ogg-ios/ogg/include/"
export PATH=`xcodebuild -version -sdk iphoneos PlatformPath`"/Applications/Xcode.app/Contents/Developer/usr/bin:$PATH"
export SDK=`xcodebuild -version -sdk iphoneos Path`
export CC="xcrun --sdk iphoneos clang -arch $ARCH $IOSMV --sysroot=$SDK -isystem $SDK/usr/include -I${OGG_DIR}"
export CXX="xcrun --sdk iphoneos clang++ -arch $ARCH $IOSMV --sysroot=$SDK -isystem $SDK/usr/include -I${OGG_DIR}"
export LDFLAGS="-Wl,-syslibroot,$SDK"

export LIBTOOL="glibtool"
export LIBTOOLIZE="glibtoolize"

cd flac

cp /usr/local/opt/gettext/share/gettext/config.rpath ./

autoheader \
	&& aclocal \
	&& ${LIBTOOLIZE} --copy --force \
    && automake --add-missing --copy \
    && autoconf

./configure --host=arm-apple-darwin --disable-ogg --disable-xmms-plugin --disable-doxygen-docs
cp config.h ../no-ogg/

./configure --host=arm-apple-darwin --disable-xmms-plugin --disable-doxygen-docs
cp config.h ../with-ogg/

cp COPYING.Xiph ../COPYING

cd ../
#git clean -f
#git clean -fd
