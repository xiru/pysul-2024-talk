#!/bin/bash

set -e

# setup venvs
cd /home/xiru
for version in $(echo 3.8.19 3.9.19 3.10.14 3.11.9 3.12.4 3.13.0rc1 3.14.0a0); {
    echo ${version}
    shortversion=${version%.*}
    rm -rf .venv-$version
    /opt/python/python-${version}/bin/python${shortversion} -m venv .venv-$version
    source .venv-$version/bin/activate
    pip install --upgrade pip
    deactivate
}

for version in $(echo 3.13.0rc1 3.14.0a0); {
    for variant in $(echo ft jit); {
        echo ${version}-${variant}
        shortversion=${version%.*}
        rm -rf .venv-${version}-${variant}
        /opt/python/python-${version}-${variant}/bin/python${shortversion} -m venv .venv-${version}-${variant}
        source .venv-${version}-${variant}/bin/activate
        pip install --upgrade pip
        deactivate
    }
}
