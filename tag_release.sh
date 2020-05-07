#!/bin/bash


# Exit if no arguments are passed
: ${1?"Usage: $0 <version_number>"}

versionLabel=v$1

# establish branch and tag name variables
devBranch=dev
masterBranch=master
releaseBranch=release-$1

if [[ `git branch | egrep "^\*?[[:space:]]+${releaseBranch}$"` ]]
then
    echo "Branch $releaseBranch exists"
else
    echo "Branch $releaseBranch does not exist"
    exit 1
fi

# merge release branch with the new version number into master
git checkout $releaseBranch
git pull origin $releaseBranch
git checkout $masterBranch
git merge --no-ff --log $releaseBranch
 
# create tag for new version from master
git tag $versionLabel -m "Release $versionLabel"

# Push the release
git push --follow-tags

# merge release branch with the new version number back into dev
git checkout $devBranch
git merge --no-ff --log $releaseBranch
 
# remove release branch
git branch -d $releaseBranch