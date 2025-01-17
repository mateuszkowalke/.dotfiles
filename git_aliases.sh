#!/bin/bash

git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.lg 'log --all --decorate --oneline --graph'
git config --global rerere.enabled true
# undo the number of changes to current branch (by default undoes one change)
git config --global alias.undo '!f() {git reset --hard $(git rev-parse --abbrev-ref HEAD)@{${1-1}}; }; f'
