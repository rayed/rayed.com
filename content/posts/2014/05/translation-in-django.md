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
<h2>Settings</h2>
<p>In your project &#8220;settings.py&#8221; setup the following values:</p>
<p><code></p>
<pre>
LOCALE_PATHS = (
    os.path.join(BASE_DIR, 'locale'),
    )
LANGUAGE_CODE = 'ar'
</pre>
<p></code></p>
<p>Here we defined the location of our translation files, by default Django will look for it under application directories under &#8220;locale&#8221; directory, but here we define it for the whole project.</p>
<p>The LANGUAGE_CODE line define a fixed translation to Arabia &#8220;ar&#8221;.</p>
<h2>Source Code</h2>
<p>For Python source code Django uses &#8220;ugettext&#8221; function aliased as &#8220;_&#8221; (underscore) to translate text strings:</p>
<p><code></p>
<pre>
from django.utils.translation import ugettext as _
from django.http import HttpResponse
from django.shortcuts import render

def page1(request):
    output = _("Welcome to my site.")
    return HttpResponse(output)

def page2(request, template_name='index.html'):
    return render(request, template_name)
</pre>
<p></code></p>
<h2>Template</h2>
<p>Inside Django templates, Django uses <strong>trans</strong> template tag with the text to translate, don&#8217;t forget to load the tag using &#8220;{% load i18n %}&#8221;</p>
<p><code></p>
<pre>
{% load i18n %}

&lt;h1>{% trans "Hello World" %}&lt;/h1>
</pre>
<p></code></p>
<h2>Commands</h2>
<p>After preparing the code we the following steps:</p>
<ul>
<li>Collect translation string using &#8220;django-admin.py makemessages&#8221; command.</li>
<li>Edit the translation file &#8220;django.po&#8221;</li>
<li>Compile the translation to &#8220;django.mo&#8221;.</li>
</ul>
<p><code></p>
<pre>
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
</pre>
<p></code></p>
<p>That&#8217;s it, you should be able to see your applications translated!</p>
