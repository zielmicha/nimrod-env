#!/bin/bash
set -e

cat index.head.html > index.html

version() {
    if [ ! -e "packages/$1.tgz" ]; then
        echo "Packing $1..."
        ./pack.sh "$2" "$1"
    fi
    echo "<div class=v>
<pre>./env.sh <a href='packages/$1.tgz'>$1</a></pre>
<div class=sha1>Revision: $2</div>
</div>" >> index.html
}

version "0.9.3-pre-891c7f11" 891c7f1167aee587db5fdd4c3b267c36de654816
