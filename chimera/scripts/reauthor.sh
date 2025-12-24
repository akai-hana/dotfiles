#!/bin/sh
read -p "user: " USER
read -p "repo: " REPO

# re-author using filter-repo
git filter-repo --commit-callback '
    commit.author_name = b"$USER"
    commit.author_email = b"akaihanatsundeee@proton.me"
    commit.committer_name = b"$USER"
    commit.committer_email = b"akaihanatsundeee@proton.me"
  ' --force

# re-set origin
git remote add origin https://github.com/$USER/$REPO.git
git remote set-url origin git@github.com:$USER/$REPO.git
