---
title: 'Minimal Django Project: Part 1 … First Run'
author: Rayed
type: post
date: 2013-02-03T17:21:01+03:00
categories:
  - Uncategorized
tags:
  - django
  - python
  - sqlite
wordpress_id: 1090

---
**Update:** Django 1.6+ don't need any of these steps! it will work out of the box. 

<a href="http://www.djangoproject.com/"><img src="https://www.djangoproject.com/m/img/badges/djangowish126x70.gif" border="0" alt="A Django site." title="I wish this site was powered by Django." align="right"/></a>

The following is the shortest way to create DB backed Django project, it uses SQLite as a backend, which make the setup very easy and fast.

I usually use for testing new Django modules or apps.


    **$ django-admin.py startproject mycms**
    **$ cd mycms**
    **mycms$ chmod +x manage.py **
    **mycms$ vi mycms/settings.py **
    import os

    PROJECT_ROOT = os.path.abspath(os.path.dirname(__name__))
    :
    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.sqlite3',
            'NAME': './mycms.db',
    :
        }
    }
    :
    TIME_ZONE = 'Asia/Riyadh'
    :
    TEMPLATE_DIRS = (
        PROJECT_ROOT + '/templates',
    )
    INSTALLED_APPS = (
    :
        'django.contrib.admin',
    :
    )
    :
    **mycms$ vi mycms/urls.py **
    # Uncomment the next two lines to enable the admin:
    from django.contrib import admin
    admin.autodiscover()

    urlpatterns = patterns('',
    :
        # Uncomment the next line to enable the admin:
        url(r'^admin/', include(admin.site.urls)),
    )
    **mycms$ ./manage.py syncdb**
    :
    provide username, email, password for admin
    :
    **mycms$ ./manage.py runserver**
    :
    To access it from outside
    :
    **mycms$ ./manage.py runserver 0.0.0.0:8080**


To access it:
<a href="http://localhost:8000/">Frontpage @ localhost</a>
<a href="http://localhost:8000/admin/">Admin @ localhost</a>

**Mac OSX errors**
You might get "ValueError: unknown locale: UTF-8" error, check this post on how to fix it.
http://rayed.com/wordpress/?p=1134

