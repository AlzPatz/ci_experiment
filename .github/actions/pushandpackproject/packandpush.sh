#!/bin/bash
echo "Environment Variables:"
echo $TOP_LEVEL_SOURCE_DIR
echo $PACKAGE_NAME_SUFFIX
echo $USE_NAME_SUFFIX
echo $VERSION_STRING
echo $NUGET_SOURCE
echo $NUGET_API_KEY
echo "-----"
echo "Current directory"
pwd
echo $PWD
ls
ROOT=$PWD
echo "Move to top level source"
cd $TOP_LEVEL_SOURCE_DIR
pwd
ls
cd $ROOT
echo "what's here"
ls
cd packages
pwd
touch ${VERSION_STRING}.txt
ls
