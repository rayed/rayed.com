---
title: Django returning JSON for AJAX requests
author: Rayed
type: post
date: 2013-12-23T17:34:30+03:00
categories:
  - Uncategorized
tags:
  - ajax
  - django
  - python
wordpress_id: 1508

---
In your `views.py` you can have a page that return JSON data for AJAX request like this:<!--more-->

    from django.http import JsonResponse

    def ajax(request):
        data = {}
        data['something'] = 'useful'
        return JsonResponse(data)


This would work fine if you fill the data your self, but if you are getting the data from a model try the following:

    from django.core import serializers
    def tasks_json(request):
        tasks = Task.objects.all()
        data = serializers.serialize("json", tasks)
        return HttpResponse(data, content_type='application/json')

If you have non trivial application, I would recommend using <a href="http://www.django-rest-framework.org/">Django Rest Framework</a> or similar frameworks for better support for REST beyond simple JSON response. 
