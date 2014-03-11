#!/bin/sh
set -e
if [ $# != 2 ]; then
    echo "Usage: ./pack.sh [git sha1] [version name]"
    exit
fi

cd Nimrod
git clean -x -f -d
git checkout -- .
git checkout "$1"

mkdir csource_build
cd csource_build
mkdir babel
cd babel
(cd ../../../babel && git archive --format tar HEAD) | tar x
cd ../..

nimrod c koch
./koch boot -d:release
PATH="$PWD/bin:$PATH" ./koch csource

cd csource_build

cp ../build.sh . || cp ../build/build.sh .
cp ../build/*.h build/ || true
cp -r ../build/*_? build/ || cp -r ../build/c_code/ .
cp -r ../lib .
cp ../../postinstall.sh .

mkdir config
cp ../config/nimrod.cfg ./config
tar -czvf ../tmp.tgz .
mv ../tmp.tgz "../../packages/$2.tgz"
