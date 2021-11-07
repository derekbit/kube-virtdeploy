#!/bin/bash

echo ">>> Installing personal tools"

export DEBIAN_FRONTEND=noninteractive

bash <(curl -Ss https://raw.githubusercontent.com/derekbit/dev-env/basic/install.sh)

git config --global user.name "Derek Su"
git config --global user.email derek.su@suse.com
git config --global core.editor vim
