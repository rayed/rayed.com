---
title: Django Multiple Settings with Single File
author: Rayed
type: post
date: 2013-12-12T14:16:10+03:00
categories:
  - Uncategorized
tags:
  - django
  - python
wordpress_id: 1493

---
Instead of having multiple settings files one for production and one for development and so on, I prefer to use an "if" statement with environment variable:<!--more-->

    ENV = os.environ.get('DJANGO_ENV', '')
    print "==== Active Env: [%s]  ====" % (ENV)    
    if ENV == "dev":
        # DEBUG
        DEBUG = True
        TEMPLATE_DEBUG = DEBUG
    else:
        DEBUG = False
        TEMPLATE_DEBUG = False

Then from your ".bashrc" file:

    export DJANGO_ENV=dev

