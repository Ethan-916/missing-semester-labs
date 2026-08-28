#!/usr/bin/env bash
set -euo pipefail

rm -rf repo_demo && mkdir repo_demo && cd repo_demo
git init -b main
echo "mode=normal" > config.txt
git add config.txt && git commit -m "Initial commit on main"

git checkout -b feature-a
echo "mode=safe" > config.txt
git commit -am "Set mode to safe"

git checkout main
git checkout -b feature-b
echo "mode=fast" > config.txt
git commit -am "Set mode to fast"

git checkout main
git merge feature-a
set +e
git merge feature-b
set -e

printf "mode=safe\nnote=reviewed\n" > config.txt
git add config.txt
git commit -m "Merge feature-b and resolve conflict"

echo "=== Conflict Simulation Completed ==="
git log --all --graph --decorate --oneline
