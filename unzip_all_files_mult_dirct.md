#!/bin/bash

for i in ./*/
do
        cd "$i";
        unzip *.zip;
        cd ../;
done
