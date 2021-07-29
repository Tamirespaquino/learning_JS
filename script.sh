#!/bin/bash

versionTag=""
targetEnv=""

# ./script.sh -v patch or minor or major AND DEV or HML or PRD
#get parameters
while getopts v:t: flag
do
  case "${flag}" in
    v) versionTag=${OPTARG};;
    t) targetEnv=${OPTARG};;
  esac
done

fullTag=$(git tag --sort version:refname | grep -i $targetEnv | tail -1) 

if [[ $fullTag == '' ]]
then
  fullTag='1.0.0'
fi
echo "Current Version: $targetEnv_$fullTag"

# select env
if [[ $targetEnv == 'DEV' ]]
then
  echo $targetEnv
elif [[ $targetEnv == 'HML' ]]
then
  echo $targetEnv
elif [[ $targetEnv == 'PRD' ]]
then 
  echo $targetEnv
else 
  echo "No env or incorrect one specified. Try: -t [DEV, HML, PRD]"
  exit 1
fi

currentVersionTagParts=(${fullTag//./ })

versionNumber1=${currentVersionTagParts[0]}
versionNumber2=${currentVersionTagParts[1]}
versionNumber3=${currentVersionTagParts[2]}

if [[ $versionTag == 'major' ]]
then
  currentVersionMajor=(${versionNumber1//_/ })
  echo "${currentVersionMajor[0]} and ${currentVersionMajor[1]}"
  versionNumber1=$((currentVersionMajor[1]+1))
elif [[ $versionTag == 'minor' ]]
then
  versionNumber2=$((versionNumber2+1))
elif [[ $versionTag == 'patch' ]]
then
  versionNumber3=$((versionNumber3+1))
fi

newTag="$targetEnv_$versionNumber1.$versionNumber2.$versionNumber3"
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
    echo "Already a tag on this commit"
fi

exit 0