#!/bin/bash
set -e
echo > index.html.tmp

version() {
    if [ ! -e "packages/$1.tgz" ]; then
        echo "Packing $1..."
        ./pack.sh "$2" "$1"
    fi
    source packages/$1.info
    echo "<div class=v>
<pre>./env.sh <a href='packages/$1.tgz'>$1</a>
# <span class=sha1>Nimrod revision: $NIMROD</span>
# <span class=sha1>Babel revision: $BABEL</span>
# Built: $(stat -c %y packages/$1.tgz)
</pre>
</div>" >> index.html.tmp1
    cat index.html.tmp1 index.html.tmp > index.html.tmp2
    mv index.html.tmp2 index.html.tmp
    rm index.html.tmp1
}

version "0.9.3-pre-891c7f11" 891c7f1167aee587db5fdd4c3b267c36de654816
version "0.9.3-pre-a262a922" a262a922eaa892dc25d884ef53bc049ead02dc84

cat index.head.html index.html.tmp index.foot.html > index.html
rm index.html.tmp
