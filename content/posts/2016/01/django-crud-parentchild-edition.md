---
title: Django CRUD Parent/Child Edition
author: Rayed
type: post
date: 2016-01-25T00:06:18+03:00
categories:
  - Uncategorized
tags:
  - child
  - crud
  - database
  - django
  - parent
  - web
wordpress_id: 1873

---
<p>I&#8217;ve <a href="https://rayed.com/wordpress/?p=1266">written before</a> about implementing CRUD operations on a single table in <a href="https://www.djangoproject.com">Django</a>, and the post was very popular on my blog and I hope many people learned something from it.</p>
<p>The next logical step is to write a CRUD application with Parent/Child relationship, the application is bit more verbose but it follow the same simple logic used in the first post.</p>
<p>In fact I didn&#8217;t write a single application, I wrote five stand alone applications that shows different ways to implement CRUD operations:</p>
<ul>
<li>books_simple: Single table CRUD operations.</li>
<li>books_pc_formset: Parent/Child CRUD operation using Django formsets, which means editing the children in the sample form as the parent.</li>
<li>books_pc_formset2: similar to previous app but uses a foreign key in the children.</li>
<li>books_pc_multiview: Parent/Child CRUD operation using multiple one view for the parent and another seperate view for the children.</li>
<li>books_pc_multiview2: similar to previous app but uses a foreign key in the children.</li>
</ul>
<p>You can find the code here:<br />
<a href="https://github.com/rayed/django-crud-parent-child">https://github.com/rayed/django-crud-parent-child</a></p>
<p>Hope you find it useful, and please let me know if it needs any improvements.</p>
