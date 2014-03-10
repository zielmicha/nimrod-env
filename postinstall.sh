#!/bin/sh
set -e
echo '-d:nimrodEnv' >> $1/babel/src/babel.nimrod.cfg
bin/nimrod c $1/babel/src/babel
bhome="$PWD"
cd $1/babel
BABEL_HOME="$bhome" src/babel -y install
cd ../..
