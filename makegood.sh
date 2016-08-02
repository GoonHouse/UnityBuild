#!/bin/bash

# $1 = source folder release
# $2 = game filename
# $3 = output folder release

if [ ! -d "$1" ]; then
        echo "THAT FOLDER DIDN'T EXIST, YOU RUINED IT.";
        exit 1;
fi
if [ -d "$1" ]; then
        echo "JUICING IT UP.";
        #linux
        mkdir -p "./$3/linux";
        tar cvpzf "./$3/linux/$2.tar.gz" "./$1/linux";
        #mac
        mkdir -p "./$3/mac";
        chmod +x "./$1/mac/$2.app/Contents/MacOS/$2";
        tar cvpzf "./$3/mac/$2.tar.gz" "./$1/mac";
        #win
        mkdir -p "./$3/win32";
        mkdir -p "./$3/win64";
        zip -r "./$3/win32/$2.zip" "./$1/win32";
        zip -r "./$3/win64/$2.zip" "./$1/win64";
        #webgl
        mkdir -p "./$3/webgl";
        cp -R "./$1/webgl" "./$3";
        exit 0;
fi
