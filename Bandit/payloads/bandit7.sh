#!/usr/bin/env bash

awk /millionth/ data.txt | awk 'NF{print $NF}'