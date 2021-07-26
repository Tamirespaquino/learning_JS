#!/bin/bash
fullTag=$(git tag --sort version:refname | tail -1)
patch=$(echo ${fullTag} | grep -zoP '(?<=\.)[^.]*$')
newPatch="$(($patch + 1))"
# 3 -> 4
echo "${fullTag/$patch/$newPatch}"
# 2.0.0 -> 2.0.1
# 2.0.0 -> 2.1.0
 
echo fullTag ${fullTag}
echo patch ${patch}
echo newPatch ${newPatch}