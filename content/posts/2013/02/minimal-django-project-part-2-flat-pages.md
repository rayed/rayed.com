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
<p>In this step we will setup the Flatpage App, Flatpage allows you to create simple static pages from the Admin interface:</p>
<pre>
<strong>mycms$ mkdir templates</strong>
<strong>mycms$ vi mycms/settings.py</strong>
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


<strong>mycms$ vi mycms/urls.py</strong>
:
# Your other patterns here
# SHOULD BE THE LAST RULE
urlpatterns += patterns('django.contrib.flatpages.views',
    (r'^(?P&lt;url>.*)$', 'flatpage'),
)

<strong>mycms$ ./manage.py syncdb</strong>
<strong>mycms$ mkdir -p templates/flatpages</strong>
<strong>mycms$ vi templates/flatpages/default.html</strong>
&lt;!DOCTYPE html>
&lt;html>
&lt;head>
&lt;title>{{ flatpage.title }}&lt;/title>
&lt;/head>
&lt;body>
&lt;h1>{{ flatpage.title }}&lt;/h1>
{{ flatpage.content }}
&lt;/body>
&lt;/html>
</pre>
<p>No from the admin interface add a new page from &#8220;Flat pages&#8221; app, and you can view directly from the normal site.</p>
