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
<p><strong>Update:</strong> Django 1.6+ don&#8217;t need any of these steps! it will work out of the box. </p>
<p><a href="http://www.djangoproject.com/"><img src="https://www.djangoproject.com/m/img/badges/djangowish126x70.gif" border="0" alt="A Django site." title="I wish this site was powered by Django." align="right"/></a></p>
<p>The following is the shortest way to create DB backed Django project, it uses SQLite as a backend, which make the setup very easy and fast.</p>
<p>I usually use for testing new Django modules or apps.</p>
<pre>
<strong>$ django-admin.py startproject mycms</strong>
<strong>$ cd mycms</strong>
<strong>mycms$ chmod +x manage.py </strong>
<strong>mycms$ vi mycms/settings.py </strong>
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
<strong>mycms$ vi mycms/urls.py </strong>
# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
:
    # Uncomment the next line to enable the admin:
    url(r'^admin/', include(admin.site.urls)),
)
<strong>mycms$ ./manage.py syncdb</strong>
:
provide username, email, password for admin
:
<strong>mycms$ ./manage.py runserver</strong>
:
To access it from outside
:
<strong>mycms$ ./manage.py runserver 0.0.0.0:8080</strong>
</pre>
<p><strong><br />
To access it:<br />
<a href="http://localhost:8000/">Frontpage @ localhost</a><br />
<a href="http://localhost:8000/admin/">Admin @ localhost</a></p>
<p></strong><strong>Mac OSX errors</strong><br />
You might get &#8220;ValueError: unknown locale: UTF-8&#8221; error, check this post on how to fix it.<br />
<a href="http://rayed.com/wordpress/?p=1134">http://rayed.com/wordpress/?p=1134</a></p>
