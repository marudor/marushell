#!/usr/bin/env sh

UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse "$UPSTREAM")
BASE=$(git merge-base @ "$UPSTREAM")

if [ $LOCAL = $REMOTE ]; then
    status="up-to-date"
elif [ $LOCAL = $BASE ]; then
    status="update"
elif [ $REMOTE = $BASE ]; then
    status="NeedsPush"
else
    status="Diverged"
fi

echo $status
if [ $status="up-to-date" ]; then
  git pull
fi
