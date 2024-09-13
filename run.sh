#!/bin/bash

set -e

cd /home/xiru
for version in $(echo 3.8.19 3.9.19 3.10.14 3.11.9 3.12.4 3.13.0rc1 3.13.0rc1-jit 3.13.0rc2 3.13.0rc2-jit 3.14.0a0 3.14.0a0-jit); {
    echo -n ${version}
    echo -n ","
    source .venv-$version/bin/activate
    python3 $@
    deactivate    
}

for version in $(echo 3.13.0rc1-ft 3.13.0rc2-ft 3.14.0a0-ft); {
    for gil in $(echo 0 1); {
        echo -n ${version} -X gil=${gil}
        echo -n ","
        source .venv-$version/bin/activate
        python3 -X gil=${gil} $@
        deactivate   
    }
}
