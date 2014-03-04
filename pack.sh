#!/bin/sh
set -e
if [ $# != 2 ]; then
    echo "Usage: ./pack.sh [git sha1] [version name]"
    exit
fi
cd Nimrod
rm -r *
git checkout -- .
git checkout "$1"
nimrod c koch
./koch csource
mkdir csource_build && cd csource_build
cp ../build.sh . || cp ../build/build.sh .
mkdir build
cp ../build/*.h build/ || true
cp -r ../build/*_? build/ || cp -r ../build/c_code/ .
cp -r ../lib .
mkdir config
cp ../config/nimrod.cfg ./config
tar -czvf ../tmp.tgz .
mv ../tmp.tgz "../../packages/$2.tgz"
