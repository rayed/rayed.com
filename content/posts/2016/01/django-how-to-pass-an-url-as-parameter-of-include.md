---
title: 'Django: How to pass an url as parameter of include'
author: Rayed
type: post
date: 2016-01-31T13:21:38+03:00
categories:
  - Uncategorized
tags:
  - django
  - python
  - template
wordpress_id: 1879
---
In [Django](https://www.djangoproject.com/) web applications I usually have a single template file for navigation or bread crumb that I include from other template files, it is easy and straight forward to pass parameter to the included template file, some thing like:

    {% include "nav.html" with title="title" object=my_object %}

But it would be a little tricker to send a URL as a parameter, i.e. you can't write it:</p>

    {# WRONG DOESN'T WORK #}
    {% include "nav.html" with title="title" link={% url 'book_edit'%} %}

But luckily Django have a decent and elegant solution, you can use "url" template function with "as" parameter, which will not display but will store it in a variable that you can use later in the include function:</p>

    {% url 'some-url-name' arg arg2 as my_link %}
    {% include "nav.html" with title="title" link=my_link %}

In fact you don't need to send my_link as it going to be visible on the included file anyway, so this will work as expected:</p>

    {% url 'some-url-name' arg arg2 as my_link %}
    {% include "nav.html" with title="title" %}
