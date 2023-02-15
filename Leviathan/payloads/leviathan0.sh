#!/usr/bin/env bash

cat .backup/bookmarks.html | grep password | head -1 | awk '{print $14}' | tr '"' ' '