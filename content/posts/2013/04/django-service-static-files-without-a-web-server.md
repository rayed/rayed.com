---
title: Django Serving Static Files without a Web Server
author: Rayed
type: post
date: 2013-04-04T02:21:16+03:00
categories:
  - Uncategorized
tags:
  - django
  - python
wordpress_id: 1165

---
**UPDATE:
Steps in this post isn't correct, check the <a href="http://rayed.com/wordpress/?p=1650">Django Themes</a> post for better solution.**

When deploying Django site it is always recommended to serve static files (e.g. js, css, img, static, media) using a normal web server instead of relying on <a href="https://docs.djangoproject.com/en/dev/ref/django-admin/#runserver-port-or-address-port">Django built development server</a> or <a href="http://gunicorn.org/">Gunicorn</a>.

But sometimes you want to test something quick and you don't want to bother with installing or configuring a web server, the solution is to use the built-in <a href="https://docs.djangoproject.com/en/1.4/howto/static-files/#django.views.static.serve">django.views.static.serve</a> view to serve the static files from Django it self:

    $ vi project/urls.py
    :
    # Serve Static Files 
    from django.conf import settings
    from django.conf.urls.static import static
    if settings.DEBUG:
        urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
        urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
        urlpatterns += patterns('django.views.static',
            url(r'^(?P&lt;path&gt;(js|css|img)/.*)$', 'serve', {'document_root':  settings.BASE_DIR+'/../www'}),
            )

Notice it is configured to work on DEBUG mode only since it isn't efficient nor tested for production use.

