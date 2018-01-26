---
title: Install Python Image Library (PIL) on OSX
author: Rayed
type: post
date: 2013-11-15T15:14:18+03:00
categories:
  - Uncategorized
tags:
  - image
  - mac
  - osx
  - pil
  - python
wordpress_id: 1433

---

<a href="http://en.wikipedia.org/wiki/Python_Imaging_Library">PIL</a> or Python Imaging Library is a library that allows you to manipulate images in Python programming language, trying to install "PIL" using "pip" tool won't work perfectly so here is how to proper installation.<!--more-->

### Install Brew

<a href="http://brew.sh/">Brew</a> is a package management system that simplifies the installation of software on Mac OS X, you can install it easily with the following command:

    ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"

### Install Pil

Actually we will install "pillow" a fork of "pil":

    brew install samueljohn/python/pillow

### Configure your Python Path

To make PIL available to Python we add its path to PYTHONPATH variable:

    vi ~/.bash_profile
    PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
    export PYTHONPATH

### Check it

To test if you have PIL installed:

    python -c "import PIL.Image"

You shouldn't get any errors.
