#!/usr/bin/env bash

mono .paket/paket.bootstrapper.exe
exit_code=$?
if [ $exit_code -ne 0 ]; then
  exit $exit_code
fi

mono .paket/paket.exe restore
exit_code=$?
if [ $exit_code -ne 0 ]; then
  exit $exit_code
fi

sudo npm install -g elm@0.18


[ ! -e build.fsx ] && mono .paket/paket.exe update
[ ! -e build.fsx ] && mono packages/FAKE/tools/FAKE.exe init.fsx
mono packages/FAKE/tools/FAKE.exe $@ --fsiargs -d:MONO build.fsx
