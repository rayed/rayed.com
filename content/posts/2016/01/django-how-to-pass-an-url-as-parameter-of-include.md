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
<p>In <a href="https://www.djangoproject.com/">Django</a> web applications I usually have a single template file for navigation or bread crumb that I include from other template files, it is easy and straight forward to pass parameter to the included template file, some thing like:</p>
<p><code>{% include "nav.html" with title="title" object=my_object %}<br />
</code></p>
<p>But it would be a little tricker to send a URL as a parameter, i.e. you can&#8217;t write it:</p>
<p><code>{# WRONG DOESN'T WORK #}<br />
{% include "nav.html" with title="title" link={% url 'book_edit'%} %}<br />
</code></p>
<p>But luckily Django have a decent and elegant solution, you can use &#8220;url&#8221; template function with &#8220;as&#8221; parameter, which will not display but will store it in a variable that you can use later in the include function:</p>
<p><code>{% url 'some-url-name' arg arg2 as my_link %}<br />
{% include "nav.html" with title="title" link=my_link %}<br />
</code></p>
<p>In fact you don&#8217;t need to send my_link as it going to be visible on the included file anyway, so this will work as expected:</p>
<p><code>{% url 'some-url-name' arg arg2 as my_link %}<br />
{% include "nav.html" with title="title" %}<br />
</code></p>
