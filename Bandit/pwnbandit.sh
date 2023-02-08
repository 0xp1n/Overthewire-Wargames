#!/usr/bin/env bash

CURRENT_DIR=$(pwd)
PAYLOADS_DIR=$CURRENT_DIR/payloads

RED='\033[0;31m' # foreground red

# Apply execute permissions on payloads
chmod -R u+x $CURRENT_DIR/**/*.sh

# Empty the flag file to star the process again
truncate -s 0 $CURRENT_DIR/bandit_flags.txt

function readLastFlag() {
    if [ -s $CURRENT_DIR/bandit_flags.txt ]; then
        echo $(cat ./bandit_flags.txt | tail -n 1) 
    else
        echo "bandit0"
    fi
}

# Bandit scripts for each level
LEVELS=14

for ((level=0;level<=LEVELS;level++)); do
    if [ -f "$PAYLOADS_DIR/bandit$level.sh" ]; then
        expect $CURRENT_DIR/expect.exp bandit$level $(readLastFlag) $PAYLOADS_DIR/bandit$level.sh
    else
        echo -e "$RED The payload for level $level does not exists with name bandit$level.sh"
    fi
done


find . -type f -name '*exp.swp' -delete