#!/bin/sh

rm -fr ./result
mkdir -p result

octave --silent --no-gui main.m 2> result/err.txt

# $Id: run.sh,v 1.3 2013/11/28 09:41:30 mechanoid Exp mechanoid $
