#!/bin/bash

versionTag=""

#get parameters
while getopts v: flag
do
  case "${flag}" in
    v) versionTag=${OPTARG};;
  esac
done

fullTag=$(git tag --sort version:refname | tail -1)
# patch=$(echo ${fullTag} | grep -zoP '(?<=\.)[^.]*$')
# newPatch="$(($patch + 1))"

currentVersionTagParts=(${fullTag// . / })

versionNumberMajor=${fullTag[0]}
versionNumberMinor=${fullTag[1]}
versionNumberPatch=${fullTag[2]}

if [[ $versionTag == 'patch' ]]
then
    versionNumberPatch=$((versionNumberPatch+1))
fi

newTag="$versionNumberMajor.$versionNumberMinor.$versionNumberPatch"
echo "($versionTag) updating $fullTag to $newTag"

gitCommit=`git rev-parse HEAD`
needsTag=`git describe --contains $gitCommit 2>/dev/null`

if [ -z "$needsTag" ]; then
    npm version $newTag
    npm publish --access public
    echo "${fullTag/$patch/$newPatch}"
    echo "Tagged with $newTag"
    echo "fullTag ${fullTag}"
    echo "patch ${patch}"
    echo "newPatch ${newPatch}"
    git tag $newTag
    git push --tasg 
    git push
else
    echo "Already a tag on this commit"
fi

exit 0


# 3 -> 4
# echo "${fullTag/$patch/$newPatch}"
# 2.0.0 -> 2.0.1
# 2.0.0 -> 2.1.0
 
# echo fullTag ${fullTag}
# echo patch ${patch}
# echo newPatch ${newPatch}

