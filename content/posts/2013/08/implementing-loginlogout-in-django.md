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
**Update: add names and namespace to URLs**

Implementing user authentication is fairly easy job in Django, many functionalities are already included in the standard Django installation, you can manage users using the default "admin" app the comes with Django.

Here I will show how implement Login/Logout feature by relying on Django built-in views.

<!--more-->

Steps:

- Create "accounts" app: we will put all "accounts" related files in this app.
- Create URL mapping for login and logout pages.
- Include "accounts" URL in the main URL mapping.
- Create login page HTML template
- Add small template code to show current user in all pages (changing base template)


Create "accounts" app:

    ./manage.py startapp accounts


Add to INSTALLED_APPS:

project_name/settings.py 

    INSTALLED_APPS = (
      :
      'accounts',
      :
    )


Create URL mapping for login and logout pages:

accounts/urls.py 

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

Include "accounts" URL in the main URL mapping:

project_name/urls.py 

    urlpatterns = patterns('',
        :
        url(r'^accounts/', include('accounts.urls', namespace='accounts')),
        :
    )


Create login page HTML template:

templates/accounts/login.html

    {% extends "base.html" %}
    {% block content %}
    {% if form.errors %}
    <p>Your username and password didn't match. Please try again.</p>
    {% endif %}
    <form method="post" action="{% url 'accounts:login' %}">
    {% csrf_token %}
    <table>
    {{ form }}
    </table>
    <input type="submit" value="login" />
    <input type="hidden" name="next" value="/" />
    </form>
    {% endblock %}


Add small template code to show current user:

template/base.html

    :
    {% if user.is_authenticated %}
        <p>Welcome, {{ user.username }}  <a href="{% url 'accounts:logout' %}">[logout]</a></p>
    {% else %}
        <p>Welcome, Guest <a href="{% url 'accounts:login' %}">[login]</a></p>
    {% endif %}
    :


For more on the subject:
<a href="https://docs.djangoproject.com/en/1.7/topics/auth/default/">Using the Django authentication system</a>



### Bonus: Password Change form


accounts/urls.py:

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


templates/accounts/password_change_form.html:

    {% extends "base.html" %}
    {% block content %}
    {% if form.errors %}
    <p>Password change failed</p>
    {% endif %}
    <form method="post" action="{% url 'accounts:password_change' %}">
    {% csrf_token %}
    <table>
    {{ form }}
    </table>
    <input type="submit" value="Change Password" />
    </form>
    {% endblock %}


templates/accounts/password_change_done.html:

    {% extends "base.html" %}
    {% block content %}
    Password successfully changed.
    <a href="/">Home</a>
    {% endblock %}


template/base.html:

    :
    {% if user.is_authenticated %}
        <p>
        Welcome, {{ user.username }}
        <a href="{% url 'accounts:password_change' %}">[Change Password]</a>
        <a href="{% url 'accounts:logout' %}">[logout]</a>
        </p>
    {% else %}
        <p>Welcome, Guest <a href="{% url 'accounts:login' %}">[login]</a></p>
    {% endif %}
    :

