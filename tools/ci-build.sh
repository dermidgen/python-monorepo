#!/bin/sh
BASEDIR=$PWD
PKG=${PWD##*/}
DEPS=`grep -o '".*libs.*"' $PWD/poetry.lock | sed -e 's/"//g' | cut -d/ -f4`

mkdir -p $BASEDIR/dist/deps

for dep in $DEPS; do
  cd ../../libs/$dep
  rm -rf ./dist/*
  poetry build
  cp dist/*.whl $BASEDIR/dist/deps/.
  cd $BASEDIR
done

cd $BASEDIR
poetry install
poetry build
