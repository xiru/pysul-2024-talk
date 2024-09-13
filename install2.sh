#!/bin/bash

set -e

# install dependencies
wget -qO- https://apt.llvm.org/llvm-snapshot.gpg.key | sudo tee /etc/apt/trusted.gpg.d/apt.llvm.org.asc
sudo apt update
sudo apt install llvm-18 clang-18

# build python with jit and free-threading
# https://peps.python.org/pep-0703/
# https://peps.python.org/pep-0744/

# build python
cd /opt/src
for version in $(echo 3.13.0rc1 3.13.0rc2 3.14.0a0); {
    for variant in $(echo ft jit); {
        echo ${version}-${variant}
        rm -rf /opt/python/python-${version}-${variant}
        if [ "$version" = "3.14.0a0" ]; then
            rm -rf cpython
            git clone https://github.com/python/cpython.git
            cd cpython
        else
            rm -rf Python-${version}
            tar -zxf Python-${version}.tgz
            cd Python-${version}
        fi
        if [ "$variant" = "ft" ]; then
            ./configure --prefix=/opt/python/python-${version}-${variant} --enable-optimizations --disable-gil
        else
            ./configure --prefix=/opt/python/python-${version}-${variant} --enable-optimizations --enable-experimental-jit=yes
        fi
        make -j2 && make altinstall
        cd -
    }
}
