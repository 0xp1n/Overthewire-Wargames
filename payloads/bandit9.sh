#!/usr/bin/env bash

strings ~/data.txt | grep '==' | tail -n 1 | awk '{print $2}'