#!/bin/bash

# Exit if no arguments are passed
: ${1?"Usage: $0 <version_number>"}

# variables
devBranch=dev
releaseBranch=release-$1
 
# create the release branch from the dev branch
git checkout $devBranch
git pull origin $devBranch
git checkout -b $releaseBranch 
git push -u origin $releaseBranch
