---
title: Django Themes (or where to put base.html?)
author: Rayed
type: post
date: 2014-09-20T21:33:23+03:00
categories:
  - Uncategorized
tags:
  - django
  - python
  - theme
  - web
wordpress_id: 1650

---


### The Wrong Way

I used to create a new directory to hold common templates like "base.html", and add it TEMPLATES_DIR in the settings.py file:<!--more-->

    TEMPLATE_DIRS = (os.path.join(BASE_DIR, 'templates') ,)

But in most cases the "base.html" would need to use CSS, JS, and image files to be functional, so I changed the url routing to access them (from the DEBUG mode only), something like:

    $ vi apps/urls.py
    :
    # Serve Static Files 
    from django.conf import settings
    from django.conf.urls.static import static
    if settings.DEBUG:
        urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
        urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
        urlpatterns += patterns('django.views.static',
            url(r'^(?P<path>(js|css|img)/.*)$', 'serve', {'document_root':  settings.BASE_DIR+'/../www'}),
            )


This setup isn't ideal for many reasons:

- I had to modify settings.py and urls.py with complicated settings.
- Theme design span multiple directories, and it isn't self contained.
- Switching the design is complicated, and include many changes.


### Django Simple Themes

Nowadays I create a new Django application e.g. "my_theme" to hold my "base.html" template and all needed static files (CSS, JS, Images, etc...).

    ./manage.py startapp my_theme

Then add it to INSTALLED_APPS:

    INSTALLED_APPS = (
        # django core apps ...
        'my_theme',
        # other apps ...
    )

The directory structure for my new app looks like this:

    my_theme/
        templates/
            base.html
        static/
            my_theme/
                css/
                js/
                img/

and from my "base.html" (or any other template) I could access the static file using the static tag:

    {% load staticfiles %}
    <img src="{% static "my_theme/img/logo.png" %}" />


I don't even need to change the "urls.py" file to access the static file, since the development server (i.e. ./manage.py runserver) already knows how to find them.

But for production I have to define:

    STATIC_ROOT = os.path.join(BASE_DIR, '../www/static')

and run:

    ./manage.py collectstatic --noinput


### New Theme

By having all theme files inside an application I can start new theme by copying "my_theme" to something like "new_theme" and replace it in the INSTALLED_APPS in the settings.py.


### What about uploaded files?

To access uploaded file from development server you need to define both `MEDIA_URL` and `MEDIA_ROOT` and change your "urls.py":

    $ vi apps/urls.py
    :
    from django.conf import settings
    from django.conf.urls.static import static
    if settings.DEBUG:
        urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

Source: [Serving files uploaded by a user during development](https://docs.djangoproject.com/en/1.7/howto/static-files/#serving-files-uploaded-by-a-user-during-development)



### Sample Theme

You can download my sample theme from: https://github.com/rayed/django_theme

