#!/bin/bash

PACKAGE_NAME="uqm"
UPSTREAM_VERSION="0.8.0"
P="${PACKAGE_NAME}-${UPSTREAM_VERSION}"

# Fetch sources
wget https://downloads.sourceforge.net/sc2/${P}-src.tgz
tar zxpvf ${P}-src.tgz
cd ${P}

# Build # Set options
cp ../config.state ./
./build.sh uqm -j2

# Copy new binary to gamedata
cp uqm ../gamedata
cd ../..

# Fetch content from upstream
if [ ! -e ./gamedata/content/packages/${P}-content.uqm]; then
    wget https://downloads.sourceforge.net/sc2/${P}-content.uqm
fi

if [ ! -e ./gamedata/content/packages/${P}-3domusic.uqm]; then
    wget https://downloads.sourceforge.net/sc2/${P}-3domusic.uqm
fi

if [ ! -e ./gamedata/content/packages/${P}-voice.uqm]; then
    wget https://downloads.sourceforge.net/sc2/${P}-voice.uqm
fi

# sed version upstream

# TODO - sed version repo with maybe r1 with counter? - manual

rm data.zip gamedata.sqfs
mksquashfs gamedata gamedata.sqfs -comp xz
cd assets; zip -r ../data.zip *; cd ..
cat gamedata.sqfs data.zip > ${P}_maquis196.dbp

## With help from the Gentoo UQM ebuild for urls
