#!/bin/bash

set -e

# install dependencies
sudo apt install build-essential libssl-dev libffi-dev libsqlite3-dev libncurses-dev libreadline-dev libgdbm-dev libgdbm-compat-dev libbz2-dev liblzma-dev uuid-dev tk-dev cargo

# build python
cd /opt/src
for version in $(echo 3.8.19 3.9.19 3.10.14 3.11.9 3.12.4 3.13.0rc1 3.13.0rc2 3.14.0a0); {
    echo ${version}
    rm -rf /opt/python/python-${version}
    if [ "$version" = "3.14.0a0" ]; then
        rm -rf cpython
        git clone https://github.com/python/cpython.git
        cd cpython
    else
        rm -rf Python-${version}
        tar -zxf Python-${version}.tgz
        cd Python-${version}
    fi
    ./configure --prefix=/opt/python/python-${version} --enable-optimizations && make -j2 && make altinstall
    cd -
}
