#!/usr/bin/env bash

# We have until grep the next output ./inhere/-file07: ASCII text
# So we need to get only the path, -F: remove the ':' character
find ./inhere -type f -exec file {} \; | grep ASCII | awk -F: '{print $1}' | xargs cat