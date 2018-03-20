---
title: My first Git Session
author: Rayed
type: post
date: 2010-10-31T08:42:27+03:00
categories:
  - Uncategorized
tags:
  - code
  - git
  - linux
  - osx
  - UNIX
wordpress_id: 789

---
This guide for my own reference please don't rely on it, for a better introduction check out <a href="http://gitref.org/">Git Reference</a> website.

Basic concept and terminologies, Git have 3 logical places:

- Working Area: normal directory where you edit your project.
- Staging Area: Think of the staging as your project state before you start your coding session, after each coding session you add your changes to staging area using `git add filename` or `git add .`
- Snapshot Area: After multiple coding sessions you would finish a logical change, e.g. adding commenting system in web site, next you need to store a snapshot of your project after these changes, you would do that with `git commit`

Setting the environment:

    git config --global user.name "Rayed Alrashed"
    git config --global user.email "my@email"
    git config --global color.ui true

Start versioning a project:

    cd my_project
    make clean
    vi .gitignore  # files you want Git to ignore, e.g. log, tmp, binaries
    git init       # Initialize Git
    git add .      # Add All files to Git tracking
    git commit     # Initial commit, get a snapshot of the project

Typical workflow:

    cd my_project
    :
    vi README
    git status -s       # Get the status of files changed
    git add README      # Add README to staging area
    :
    git commit -m "Describe your change"        # Make a snapshot of the staging area
