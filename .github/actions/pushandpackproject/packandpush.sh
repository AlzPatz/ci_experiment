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
ls
cd .
echo "Have moved to ., where are we now"
pwd
ls
echo "Move to top level source"
cd $TOP_LEVEL_SOURCE_DIR
pwd
ls
cd .
cd packages
touch ${VERSION_STRING}.txt
ls
