#!/bin/bash

# Store top level directory, as . does not work as it does in the github composite action
ROOT=$PWD

# Delete any existing packages stored in the output folder (when this action is used multiple times we just use the last set of packages)
cd packages
rm -f *

# Go to the directory that contains the project subfolder directories
cd $ROOT
cd $TOP_LEVEL_SOURCE_DIR

# Loop through each subdirectory (each should hold a project to pack and push)
# Remove old .npkg files and set <ProjectId> and <Version> in .csproj
for dir in *; do
    # Will not run if no directories are available
    if [ -d "$dir" ]; then
        # Will not run if directory name has test within it
        if [[ ${dir} != *"test"* ]] && [[ ${dir} != *"Test"* ]]; then
            #echo $dir
            cd $dir
            rm -f *.nupkg
            # Loop through all .csproj files (should only be one per folder)
            for proj in *.csproj; do
                # Will not run if no files are found
                [ -f "$proj" ] || break
                # We take the project filename before the final .
                PROJECT_NAME=${proj%.*}
                # Add suffix if desired
                if [ "$USE_NAME_SUFFIX" = true ]; then
                    PROJECT_NAME="${PROJECT_NAME}${PACKAGE_NAME_SUFFIX}"
                fi
                #echo $PROJECT_NAME
                
                #Replace Project name in .csproj with generated name
                sed -i "s/<PackageId>.*<\/PackageId>/<PackageId>$PROJECT_NAME<\/PackageId>/g" $proj
                
                #Replace Version string in .csproj with generated name
                sed -i "s/<Version>.*<\/Version>/<Version>$VERSION_STRING<\/Version>/g" $proj
            done    
            cd ..
        fi
    fi
done

# Now all projects have the correct project names and versions, we can loop through and pack and push, and then store the packages in the storage directory
for dir in *; do
    # Will not run if no directories are available
    if [ -d "$dir" ]; then
        # Will not run if directory name has test within it
        if [[ ${dir} != *"test"* ]] && [[ ${dir} != *"Test"* ]]; then
            cd $dir

            dotnet pack -c "$BUILD_CONFIGURATION" -o .
            dotnet nuget push *.nupkg -s $NUGET_SOURCE -k $NUGET_API_KEY --skip-duplicate 
            
            cp *.nupkg ${ROOT}/packages/
            
            cd ..
        fi
    fi
done
