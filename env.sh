#!/bin/sh
set -e
STABLE_VERSION=0.9.2
MIRROR_URL=https://zielm.com/nimrod/packages
if [ "$NIMRODENV_MIRROR_URL" != "" ]; then
    MIRROR_URL=$NIMRODENV_MIRROR_URL
fi
if [ ! -e .nimrodenv ]; then
    mkdir .nimrodenv
fi

if [ "$1" = "-h" -o "$1" = "--help" ]; then
    echo "Usage: ./env.sh [nimrod version]" >&2
    exit 1
fi

if [ "$1" = "" ]; then
    version="$STABLE_VERSION"
else
    version="$1"
fi

# Download package
cd .nimrodenv
dir="build`date +%s`"
mkdir $dir && cd $dir
curl --fail $MIRROR_URL/"$version".tgz > fetch.tgz
tar xf fetch.tgz

# Build bin/nimrod
chmod +x build.sh
./build.sh

# Move files around
[ -e ../bin ] || mkdir ../bin
cp bin/nimrod ../bin
[ -e ../lib ] || mv lib ../
[ -e ../config ] || mv config ../
cd ..
rm -r $dir

# Generate wrapper
cat > activate <<EOF
export PATH="$PWD:\$PATH/bin"
hash -r
EOF
