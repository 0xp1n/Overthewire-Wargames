#!/usr/bin/env bash

CURRENT_DIR=$(pwd)
PAYLOADS_DIR=$CURRENT_DIR/payloads

# Apply execute permissions on payloads
chmod -R u+x $CURRENT_DIR/**/*.sh

# Empty the flag file to star the process again
truncate -s 0 $CURRENT_DIR/leviathan_flags.txt

function readLastFlag() {
    if [ -s $CURRENT_DIR/leviathan_flags.txt ]; then
        echo $(cat ./leviathan_flags.txt | tail -n 1) 
    else
        echo "leviathan0"
    fi
}

# Bandit scripts for each level
LEVELS=7

for ((level=0;level<=LEVELS;level++)); do
    if [ -f "$PAYLOADS_DIR/leviathan$level.sh" ]; then
        expect $CURRENT_DIR/expect.exp leviathan$level $(readLastFlag) $PAYLOADS_DIR/leviathan$level.sh
        echo "Leviathan flag for level $level retrieved with success!"
    else
        echo -e "$RED The payload for level $level does not exists with name leviathan$level.sh"
        exit 1
    fi
done


find . -type f -name '*exp.swp' -delete