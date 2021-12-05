#!/usr/bin/env sh

ZK_PATH="~/Documents/PKM/"

cd "$ZK_PATH"

CHANGES_EXIST="$(git status --procelain | wc -l)"

if [ "$CHANGES_EXIST" -eq 0 ]; then
    exit 0
fi

git pull
git add .
git commit -q -m "Last Sync: $(date +"%Y-%m-%d %H:%M:%S")"
git push -q
