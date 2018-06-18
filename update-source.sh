#!/bin/bash

SRC_BASE=${SRC_BASE:-src}
SRC_REPO=${SRC_REPO:-git@github.com:louiswilliams/mongo}
SRC_BRANCH=${SRC_BRANCH:-master}
GIT_PUSH=${GIT_PUSH:-false}

set -e 
if [ ! -d "$SRC_BASE" ]; then
    echo "Cloning source into $SRC_BASE from $SRC_REPO"
    git clone $SRC_REPO $SRC_BASE
fi

GIT_ROOT=$(pwd)

cd $SRC_BASE
git pull
git checkout $SRC_BRANCH
cd docs
doxygen storage.Doxyfile

cd $GIT_ROOT

rm -rf $SRC_BRANCH
echo "in `pwd`"
cp -R $SRC_BASE/docs/html $SRC_BRANCH

if [ "$GIT_PUSH" = "true" ]; then
    git add $SRC_BRANCH
    git commit -m "Updating source for $(date). This is an automatic commit"
    git push
else
    echo "skipping push"
fi
