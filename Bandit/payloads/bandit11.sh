#!/usr/bin/env bash

# We can rotate characters with tr with the help of regex, so an 'A' is transformed into 'N' or an 'a' is transformed into 'n' also on lowercase
cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m' | awk '{print $NF}'