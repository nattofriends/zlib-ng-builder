#!/bin/bash

set -ex

rm -rf zlib-ng *.deb

git clone https://github.com/zlib-ng/zlib-ng ||:

pushd zlib-ng

git fetch --tags
git checkout $VERSION

make distclean ||:

cmake -D ZLIB_COMPAT=ON -D WITH_NATIVE_INSTRUCTIONS=ON -D ZLIB_ENABLE_TESTS=OFF -D SUFFIX="ng" .
cmake --build . --config Release
cpack -G DEB -D CPACK_PACKAGE_CONTACT="No Maintainer <maintainer@example.com>" -D CPACK_PACKAGING_INSTALL_PREFIX=/opt/zlib-ng -D CPACK_PACKAGE_NAME=zlib-ng --config CPackConfig.cmake

popd

fakeroot deb-reversion zlib-ng/package/*.deb -v $VERSION
