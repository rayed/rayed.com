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
<h3>The Wrong Way</h3>
<p>I used to create a new directory to hold common templates like &#8220;base.html&#8221;, and add it TEMPLATES_DIR in the settings.py file:<br />
<code></p>
<pre>
TEMPLATE_DIRS = (os.path.join(BASE_DIR, 'templates') ,)
</pre>
<p></code></p>
<p>But in most cases the &#8220;base.html&#8221; would need to use CSS, JS, and image files to be functional, so I changed the url routing to access them (from the DEBUG mode only), something like:</p>
<p><code></p>
<pre>
$ vi apps/urls.py
:
# Serve Static Files 
from django.conf import settings
from django.conf.urls.static import static
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
    urlpatterns += patterns('django.views.static',
        url(r'^(?P&lt;path>(js|css|img)/.*)$', 'serve', {'document_root':  settings.BASE_DIR+'/../www'}),
        )
</pre>
<p></code></p>
<p>This setup isn&#8217;t ideal for many reasons:</p>
<ul>
<li>I had to modify settings.py and urls.py with complicated settings.</li>
<li>Theme design span multiple directories, and it isn&#8217;t self contained.</li>
<li>Switching the design is complicated, and include many changes.</li>
</ul>
<h3>Django Simple Themes</h3>
<p>Nowadays I create a new Django application e.g. &#8220;my_theme&#8221; to hold my &#8220;base.html&#8221; template and all needed static files (CSS, JS, Images, etc &#8230;).</p>
<p><code></p>
<pre>./manage.py startapp my_theme</pre>
<p></code></p>
<p>Then add it to INSTALLED_APPS:<br />
<code></p>
<pre>
INSTALLED_APPS = (
    # django core apps ...
    'my_theme',
    # other apps ...
)</pre>
<p></code></p>
<p>The directory structure for my new app looks like this:<br />
<code></p>
<pre>
my_theme/
    templates/
        base.html
    static/
        my_theme/
            css/
            js/
            img/
</pre>
<p></code></p>
<p>and from my &#8220;base.html&#8221; (or any other template) I could access the static file using the static tag:<br />
<code></p>
<pre>{% load staticfiles %}
&lt;img src="{% static "my_theme/img/logo.png" %}" />
</pre>
<p></code></p>
<p>I don&#8217;t even need to change the &#8220;urls.py&#8221; file to access the static file, since the development server (i.e. ./manage.py runserver) already knows how to find them.</p>
<p>But for production I have to define:<br />
<code></p>
<pre>STATIC_ROOT = os.path.join(BASE_DIR, '../www/static')</pre>
<p></code></p>
<p>and run:<br />
<code></p>
<pre>./manage.py collectstatic --noinput</pre>
<p></code></p>
<h3>New Theme</h3>
<p>By having all theme files inside an application I can start new theme by copying &#8220;my_theme&#8221; to something like &#8220;new_theme&#8221; and replace it in the INSTALLED_APPS in the settings.py.</p>
<h3>What about uploaded files?</h3>
<p>To access uploaded file from development server you need to define both <code>MEDIA_URL</code> and <code>MEDIA_ROOT</code> and change your &#8220;urls.py&#8221;:<br />
<code></p>
<pre>
$ vi apps/urls.py
:
from django.conf import settings
from django.conf.urls.static import static
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
</pre>
<p></code></p>
<p>Source: <a href="https://docs.djangoproject.com/en/1.7/howto/static-files/#serving-files-uploaded-by-a-user-during-development">Serving files uploaded by a user during development</a></p>
<h3>Sample Theme</h3>
<p>You can download my sample theme from:<br />
<a href="https://github.com/rayed/django_theme">https://github.com/rayed/django_theme</a></p>
