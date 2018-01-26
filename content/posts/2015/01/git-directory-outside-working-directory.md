---
title: Git directory outside working directory
author: Rayed
type: post
date: 2015-01-15T13:13:03+03:00
categories:
  - Uncategorized
tags:
  - apache
  - git
  - nginx
  - PHP
  - web
wordpress_id: 1751

---

I have an old PHP website that I wanted to have its code/content versioned with Git, normally Git setup the repo directory in the ".git" directory inside the working directory, but I faced a problem, if the working directory is accessible from the web server it means ".git" is also accessible too.

Luckily git have an option to have the repo directory located somewhere else using the GIT_DIR environment variable, so here what I did:

    $ vi .profile
    GIT_DIR=/home/rayed/my_website_git
    GIT_WORK_TREE=/var/www/my_website
    export GIT_DIR
    export GIT_WORK_TREE

You notice that the web site is located in "/var/www/my_website" but the repo is located under totally different directory "/home/rayed/my_website_git", so the web server can't access it by mistake.

