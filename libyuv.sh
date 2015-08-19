#!/bin/bash

function realpath (){ echo $(cd $(dirname "$1"); pwd)/$(basename "$1"); }
__FILE__=`realpath "$0"`
__DIR__=`dirname "${__FILE__}"`

source /etc/profile
source ~/.profile

BASEDIR_PATH="$1"

BUILD_DIR=$__DIR__/build

SRC_DIR=$BUILD_DIR/libyuv

DEPOT_TOOLS_DIR=$SRC_DIR/depot_tools

TARGET_SVN=https://chromium.googlesource.com/libyuv/libyuv 

DEPOT_TOOLS_GIT=https://chromium.googlesource.com/chromium/tools/depot_tools.git

echo $BUILD_DIR

function installDepotTools(){
	if [ ! -d "$DEPOT_TOOLS_DIR" ] 
	then
		git clone $DEPOT_TOOLS_GIT $DEPOT_TOOLS_DIR
	fi
	export PATH=:$DEPOT_TOOLS_DIR:"$PATH"
}

function downloadSources(){
	cd $BUILD_DIR
	gclient config $TARGET_SVN
	gclient sync
	
}

installDepotTools
downloadSources
