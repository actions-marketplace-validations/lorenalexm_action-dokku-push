#!/bin/sh -l

script_dir=$(dirname $0)

. "$script_dir/setup-ssh.sh"

echo ""
echo "Pushing to Dokku Host";

git push $DOKKU_REPO main --force

[ $? -eq 0 ]  || exit 1

