---
title: Implementing Login/Logout in Django
author: Rayed
type: post
date: 2013-08-21T19:21:46+03:00
categories:
  - Uncategorized
tags:
  - development
  - django
  - python
  - web
wordpress_id: 1350

---
<p><strong>Update: add names and namespace to URLs</strong></p>
<p>Implementing user authentication is fairly easy job in Django, many functionalities are already included in the standard Django installation, you can manage users using the default &#8220;admin&#8221; app the comes with Django.</p>
<p>Here I will show how implement Login/Logout feature by relying on Django built-in views.</p>
<p>Steps:</p>
<ul>
<li>Create &#8220;accounts&#8221; app: we will put all &#8220;accounts&#8221; related files in this app.</li>
<li>Create URL mapping for login and logout pages.</li>
<li>Include &#8220;accounts&#8221; URL in the main URL mapping.</li>
<li>Create login page HTML template</li>
<li>Add small template code to show current user in all pages (changing base template)</li>
</ul>
<p><code></p>
<pre>
# Create "accounts" app
<strong>$ ./manage.py startapp accounts</strong>
# Add to INSTALLED_APPS
<strong>$ vi project_name/settings.py </strong>
INSTALLED_APPS = (
  :
  'accounts',
  :
)


# Create URL mapping for login and logout pages
<strong>$ vi accounts/urls.py </strong>
from django.conf.urls import patterns, url
urlpatterns = patterns('',
    url(
        r'^login/$',
        'django.contrib.auth.views.login',
        name='login',
        kwargs={'template_name': 'accounts/login.html'}
    ),
    url(
        r'^logout/$',
        'django.contrib.auth.views.logout',
        name='logout',
        kwargs={'next_page': '/'}
    ),
)

# Include "accounts" URL in the main URL mapping
<strong>$ vi project_name/urls.py </strong>
urlpatterns = patterns('',
    :
    url(r'^accounts/', include('accounts.urls', namespace='accounts')),
    :
)


# Create login page HTML template
<strong>$ vi templates/accounts/login.html</strong>
{% extends "base.html" %}
{% block content %}
{% if form.errors %}
&lt;p>Your username and password didn't match. Please try again.&lt;/p>
{% endif %}
&lt;form method="post" action="{% url 'accounts:login' %}">
{% csrf_token %}
&lt;table>
{{ form }}
&lt;/table>
&lt;input type="submit" value="login" />
&lt;input type="hidden" name="next" value="/" />
&lt;/form>
{% endblock %}


# Add small template code to show current user
<strong>$ vi template/base.html</strong>
:
{% if user.is_authenticated %}
    &lt;p>Welcome, {{ user.username }}  &lt;a href="{% url 'accounts:logout' %}">[logout]&lt;/a>&lt;/p>
{% else %}
    &lt;p>Welcome, Guest &lt;a href="{% url 'accounts:login' %}">[login]&lt;/a>&lt;/p>
{% endif %}
:
</pre>
<p></code><code></code></p>
<p>For more on the subject:<br />
<a href="https://docs.djangoproject.com/en/1.7/topics/auth/default/">Using the Django authentication system</a></p>
<h2>Bonus: Password Change form</h2>
<p><!--more--></p>
<p><code></p>
<pre>
<strong>$ vi accounts/urls.py</strong>
from django.conf.urls import patterns, url
urlpatterns = patterns('',
    :
    url(
        r'^password_change$',
        'django.contrib.auth.views.password_change',
        name='password_change',
        kwargs={
               'template_name': 'accounts/password_change_form.html',
               'post_change_redirect':'accounts:password_change_done',
               }
    ),
    url(
        r'^password_change_done$',
        'django.contrib.auth.views.password_change_done',
        name='password_change_done',
        kwargs={'template_name': 'accounts/password_change_done.html'}
    ),
    :
)


<strong>$ vi templates/accounts/password_change_form.html</strong>
{% extends "base.html" %}
{% block content %}
{% if form.errors %}
&lt;p>Password change failed&lt;/p>
{% endif %}
&lt;form method="post" action="{% url 'accounts:password_change' %}">
{% csrf_token %}
&lt;table>
{{ form }}
&lt;/table>
&lt;input type="submit" value="Change Password" />
&lt;/form>
{% endblock %}


<strong>$ vi templates/accounts/password_change_done.html</strong>
{% extends "base.html" %}
{% block content %}
Password successfully changed.
&lt;a href="/">Home&lt;/a>
{% endblock %}


<strong>$ vi template/base.html</strong>
:
{% if user.is_authenticated %}
    &lt;p>
    Welcome, {{ user.username }}
    &lt;a href="{% url 'accounts:password_change' %}">[Change Password]&lt;/a>
    &lt;a href="{% url 'accounts:logout' %}">[logout]&lt;/a>
    &lt;/p>
{% else %}
    &lt;p>Welcome, Guest &lt;a href="{% url 'accounts:login' %}">[login]&lt;/a>&lt;/p>
{% endif %}
:
</pre>
<p></code></p>
