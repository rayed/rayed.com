---
title: Translation in Django
author: Rayed
type: post
date: 2014-05-17T23:02:11+03:00
categories:
  - Uncategorized
tags:
  - dev
  - django
  - web
wordpress_id: 1599

---

Preparing Django project to support multiple langauges is easier than you think!<!--more-->

### Settings

In your project "settings.py" setup the following values:

    LOCALE_PATHS = (
        os.path.join(BASE_DIR, 'locale'),
        )
    LANGUAGE_CODE = 'ar'

Here we defined the location of our translation files, by default Django will look for it under application directories under "locale" directory, but here we define it for the whole project.

The LANGUAGE_CODE line define a fixed translation to Arabia "ar".


### Source Code

For Python source code Django uses "ugettext" function aliased as "_" (underscore) to translate text strings:

    from django.utils.translation import ugettext as _
    from django.http import HttpResponse
    from django.shortcuts import render

    def page1(request):
        output = _("Welcome to my site.")
        return HttpResponse(output)

    def page2(request, template_name='index.html'):
        return render(request, template_name)


### Template

Inside Django templates, Django uses <strong>trans</strong> template tag with the text to translate, don't forget to load the tag using "{% load i18n %}"

    {% load i18n %}

    <h1>{% trans "Hello World" %}</h1>


### Commands

After preparing the code we execute the following steps:

- Collect translation string using "django-admin.py makemessages" command.
- Edit the translation file "django.po"
- Compile the translation to "django.mo".

Here are the steps:

    $ cd project_home

    # Make the "locale" directory to store translation data
    $ mkdir locale

    # scan the project for translation strings
    $ django-admin.py makemessages -l ar

    # Edit the translation file and add your translation
    $ vi locale/ar/LC_MESSAGES/django.po
    :
    msgid "Hello World"
    msgstr "مرحبا يا عالم"
    :

    # compile django.po to django.mo
    $ django-admin.py compilemessages

That's it, you should be able to see your applications translated!

