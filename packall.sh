#!/bin/bash
set -e

version() {
    if [ ! -e "packages/$1.tgz" ]; then
        echo "Packing $1..."
        ./pack.sh "$2" "$1"
    fi
}

version "0.9.3-pre-891c7f11" 891c7f1167aee587db5fdd4c3b267c36de654816
