#!/usr/bin/env bash

base64 -d ~/data.txt | tr ' ' '\n' | tail -n 1