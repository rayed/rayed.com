---
title: 'Minimal Django Project: Part 2 … Flat Pages'
author: Rayed
type: post
date: 2013-02-03T17:59:29+03:00
categories:
  - Uncategorized
tags:
  - django
  - python
wordpress_id: 1099

---
In this step we will setup the Flatpage App, Flatpage allows you to create simple static pages from the Admin interface:


    **mycms$ mkdir templates**
    **mycms$ vi mycms/settings.py**
    :
    MIDDLEWARE_CLASSES = (
    :
        # Add Flatpage Middleware
        'django.contrib.flatpages.middleware.FlatpageFallbackMiddleware',
    )
    :
    TEMPLATE_DIRS = (
        :
        '/Users/rayed/python/mycms/templates',
    )
    :
    INSTALLED_APPS = (
    :
        # Add Flat Pages App
        'django.contrib.flatpages',
    :
    )
    :


    **mycms$ vi mycms/urls.py**
    :
    # Your other patterns here
    # SHOULD BE THE LAST RULE
    urlpatterns += patterns('django.contrib.flatpages.views',
        (r'^(?P<url>.*)$', 'flatpage'),
    )

    **mycms$ ./manage.py syncdb**
    **mycms$ mkdir -p templates/flatpages**
    **mycms$ vi templates/flatpages/default.html**
    <!DOCTYPE html>
    <html>
    <head>
    <title>{{ flatpage.title }}</title>
    </head>
    <body>
    <h1>{{ flatpage.title }}</h1>
    {{ flatpage.content }}
    </body>
    </html>


Now from the admin interface add a new page from "Flat pages" app, and you can view directly from the normal site.

