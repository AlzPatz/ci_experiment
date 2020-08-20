#!/bin/bash

# Store top level directory, as . does not work as it does in the github composite action
ROOT=$PWD

# Delete any existing packages stored in the output folder 
cd packages
rm -f *

# Go to the directory that contains the project subfolder directories
cd $ROOT
cd $TOP_LEVEL_SOURCE_DIR

ls

# Loop through each subdirectory (each should hold a project to pack and push)
# Remove old .npkg files and set <ProjectId> and <Version> in .csproj
for dir in *; do
    # Will not run if no directories are available
    if [ -d "$dir" ]; then
        # Will not run if directory name has test within it
        if [[ ${dir} != *"test"* ]]; then
            echo $dir
            cd $dir
            rm -f *.nupkg
            # Loop through all .csproj files (should only be one per folder)
            for proj in *.csproj; do
                # Will not run if no files are found
                [ -f "$proj" ] || break
                echo $proj
            done    
            cd ..
        fi
    fi
done

#echo "Environment Variables:"
#echo $TOP_LEVEL_SOURCE_DIR
#echo $PACKAGE_NAME_SUFFIX
#echo $USE_NAME_SUFFIX
#echo $VERSION_STRING
#echo $NUGET_SOURCE
#echo $NUGET_API_KEY
#echo "-----"
#echo "Current directory"
#pwd
#echo $PWD
#ls
#ROOT=$PWD
#echo "Move to top level source"
#cd $TOP_LEVEL_SOURCE_DIR
#pwd
#ls
#cd $ROOT
#echo "what's here"
#ls
#cd packages
#pwd
#touch ${VERSION_STRING}.txt
#ls
