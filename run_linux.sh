#!/bin/bash

#check presence of required 
for bin in python3 git; do
    resolved="$(which $bin)"
    if [ -z "$resolved" ]; then
        echo "$bin is not found in your \$PATH. Consult your linux distribution for installation instructions or create an alias if already installed." 1>&2
    fi
done

# 1) initialize submodules recursively
if [ ! -e pythonsrc/widgets/__init__.py ]; then
    git submodule update --init --recursive

    # 2) ask for Schools dir for linking
    echo please enter location of HHS+ Schools directory
    read schools

    cd pythonsrc
    ln -s "$schools"
    cd -
fi

# 3) build launcher

cd interpreter/

if [ ! -e build/ ]; then
    python3 setup.py build
fi

python3 launcher.py

