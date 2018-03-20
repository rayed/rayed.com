---
title: "GO language Environment Setup"
date: 2018-03-20T13:36:00+03:00
---

Here I'll write about setting up a GO language envirounment in MacOS and CentOS.

<!--more-->

## Installation

### MacOS

    brew install go
    brew install dep

### CentOS

    sudo yum install golang

    # Install "dep"
    go get -d -u github.com/golang/dep
    cd $(go env GOPATH)/src/github.com/golang/dep
    DEP_LATEST=$(git describe --abbrev=0 --tags)
    git checkout $DEP_LATEST
    go install -ldflags="-X main.version=$DEP_LATEST" ./cmd/dep
    git checkout master


## Enviroument Setup

    echo 'export GOPATH=$HOME/go' >> ~/.bash_profile
    echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bash_profile
    source ~/.bash_profile


## Project Setup

All projects should reside inside GOPATH directory, the default is "$HOME/go", of course you can change it to whatever you like.

Each of your projects should be located under the following directory:

    $GOPATH/src/__user_id__/project_name

For "__user_id__" I usually use my github account URL, or my own domain, e.g.:

- `$GOPATH/src/github.com/rayed/project_name`
- `$GOPATH/src/rayed.com/project_name`

As an example of new project setup, I run the following commands:

    # Create new directory for the project and switch to it
    mkdir -p $GOPATH/rayed.com/project1
    cd $GOPATH/rayed.com/project1

    # Create README.md file
    touch README.md

    # Initalize git
    git init 
    # git should ignore "vendor" directoy, it should be managed by "dep"
    echo "/vendor" >> .gitignore

    # Initalize "dep" for dependencies managment
    dep init 
    # Always use "dep ensure" command to dependencies
    #   instead of "go get"
    dep ensure -add github.com/foo/bar github.com/baz/quux
