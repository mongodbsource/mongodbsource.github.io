#!/bin/bash

SRC_BASE=${SRC_BASE:-src}
SRC_REPO=${SRC_REPO:-git@github.com:mongodb/mongo}
SRC_BRANCH=${SRC_BRANCH:-master}

set -e 
if [ ! -d "$SRC_BASE" ]; then
    echo "Cloning source into $SRC_BASE from $SRC_REPO"
    git clone $SRC_REPO $SRC_BASE
fi

cd $SRC_BASE
git checkout $SRC_BRANCH
cd docs
doxygen storage.Doxyfile
cd ..

rm -rf $SRC_BRANCH
cp -R $SRC_BASE/docs/html $SRC_BRANCH
