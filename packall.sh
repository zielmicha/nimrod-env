#!/bin/bash
set -e

version() {
    if [ ! -e "packages/$1.tgz" ]; then
        echo "Packing $1..."
        ./pack.sh "$2" "$1"
    fi
}

version "0.9.2" a26e12b0e5c443eac1ad9c92e735eab8258b45b6
version "0.9.3-pre-891c7f11" 891c7f1167aee587db5fdd4c3b267c36de654816
