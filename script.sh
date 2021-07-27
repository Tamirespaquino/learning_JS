#!/bin/bash

versionTag=""

# ./script.sh -v patch or minor or major
#get parameters
while getopts v: flag
do
  case "${flag}" in
    v) versionTag=${OPTARG};;
  esac
done

# fullTag=`git describe --abbrev=0 --tags 2>/dev/null`
fullTag=$(git tag --sort version:refname | tail -1)

currentVersionTagParts=(${fullTag//./ })

versionNumber1=${currentVersionTagParts[0]}
versionNumber2=${currentVersionTagParts[1]}
versionNumber3=${currentVersionTagParts[2]}

if [[ $versionTag == 'patch' ]]
then
    versionNumber3=$((versionNumber3+1))
fi

newTag="$versionNumber1.$versionNumber2.$versionNumber3"
echo "($versionTag) updating $fullTag to $newTag"

#it sees if the last commit has a tag or not. If it hasn't, it associates the newTag
gitCommit=`git rev-parse HEAD`
needsTag=`git describe --contains $gitCommit 2>/dev/null`

if [ -z "$needsTag" ]; then
    echo "Tagged with $newTag"
    echo "newTag ${newTag}"
    git tag $newTag
    git push --tags 
    git push
else
    echo "Already a tag on this commit. That's great"
fi

exit 0