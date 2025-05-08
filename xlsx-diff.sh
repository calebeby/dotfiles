#!/bin/sh

ssconvert "$1" --export-type Gnumeric_stf:stf_csv fd://1 2>/dev/null | sed "s/,/|/g"
