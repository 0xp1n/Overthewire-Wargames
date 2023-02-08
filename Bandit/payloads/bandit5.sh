#!/usr/bin/env bash

## 
# If we try to open this file we encounter another problem, 
# the content is full of spaces so we need to do some kind of transformation
# before pass the output to the cat command.
# The easy way is use xargs on the next pipe, this command by default 
# will format the content so we can see now the password more readable:
##
find ./inhere/ -type f ! -executable -size 1033c | xargs cat | xargs
