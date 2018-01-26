---
title: Go Language Setup for Multiple Projects
author: Rayed
type: post
date: 2016-12-29T14:29:45+03:00
categories:
  - Uncategorized
tags:
  - development
  - go
  - golang
  - linux
wordpress_id: 1992

---
When working with [Go](https://golang.org/) language you must setup the GOPATH environment variable, but soon you will face two problems:

- Each project should have its own Go dependencies and its own Git code repo, so putting your source under GOPATH would be problematic.
- When working with "Atom" with "Go Plus" plugin, it needs to install several Go packages which would pollute your own source.

To solve both problems I added the following to my ".bash_login":<br />

    export GOPATH=$HOME/go
    alias atom='PATH=$PATH:$HOME/go/bin GOPATH=$HOME/go:$GOPATH atom'
    gpp() {
            export GOPATH=`pwd`
    }

It perform the following:

- Set a default GOPATH to $HOME/go_sandbox for testing small Go projects
- Set an alias for "atom" to add an extra dir in GOPATH and PATH, so whatever GO Plus plugin add won't be add to your current GOPATH
- Setup a "gpp" function to quickly change GOPATH to current directory

