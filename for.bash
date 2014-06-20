#!/bin/bash

for f in $(ls) ; do
    cp $f $f.org
done
