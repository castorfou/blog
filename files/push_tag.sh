#!/bin/bash
nbdev_bump_version
LAST_GIT_COMMENT=`git log -1 --pretty=%B`
VERSION_TO_TAG=`grep "version " settings.ini | cut -d '=' -f 2`

echo "Tag: $VERSION_TO_TAG - Comment: $LAST_GIT_COMMENT"

git add -A
git commit -am"$LAST_GIT_COMMENT"
git tag -a $VERSION_TO_TAG -m "$LAST_GIT_COMMENT"
git push origin $VERSION_TO_TAG
