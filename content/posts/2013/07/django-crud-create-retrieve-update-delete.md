---
title: Django CRUD (Create, Retrieve, Update, Delete)
author: Rayed
type: post
date: 2013-07-19T06:25:53+03:00
categories:
  - Uncategorized
tags:
  - django
  - python
wordpress_id: 1266

---
**UPDATE 1**: The main example use **Class Based Views**, I also added **Function Based Views** version of the same functionality.

**UPDATE 2**: I added a new example application with user access, user must login and each user has his own list.
**Sample Code:** You can download a sample application from (https://github.com/rayed/django_crud)

**UPDATE 3**: You might be interested in [Django CRUD Parent/Child Edition](/posts/2016/01/django-crud-parentchild-edition/)

In this post I briefly cover the step needed to create a CRUD app in Django, the steps we will need are:

<!--more-->

- Create an App
- Create the Model
- Create the Admin Interface (optional)
- Create the View
- Define the URLs (i.e. URL to View mapping)
- Create the Templates






### Create new App

From the Django project directory we will create the new app called "servers" to store our servers information:

    ./manage.py startapp servers

We will also need to register the new app in our Django project, add the app 'server' to the INSTALLED_APPS in your **django_proj_name/settings.py**:

    INSTALLED_APPS = (
    :
    'servers',
    :
    )


### Create the Model

The model file would be **servers/models.py**:

    from django.db import models
    from django.core.urlresolvers import reverse

    class Server(models.Model):
        name = models.CharField(max_length=200)
        ip = models.GenericIPAddressField()
        order = models.IntegerField()

        def __unicode__(self):
            return self.name

        def get_absolute_url(self):
            return reverse('server_edit', kwargs={'pk': self.pk})

After defining the model you need to provision it to the database:

    ./manage.py makemigrations
    ./manage.py migrate

To create the table for the new model.



### Admin Interface (optional)

Django will give you free CRUD interface from the admin site, just define the file **servers/admin.py** as:

    from django.contrib import admin
    from servers.models import Server

    admin.site.register(Server)


### The Views

We will use Django Class-based views to create our app pages, the file **servers/views.py** would look like:

    from django.http import HttpResponse
    from django.views.generic import TemplateView,ListView
    from django.views.generic.edit import CreateView, UpdateView, DeleteView
    from django.core.urlresolvers import reverse_lazy

    from servers.models import Server

    class ServerList(ListView):
        model = Server

    class ServerCreate(CreateView):
        model = Server
        success_url = reverse_lazy('server_list')
        fields = ['name', 'ip', 'order']

    class ServerUpdate(UpdateView):
        model = Server
        success_url = reverse_lazy('server_list')
        fields = ['name', 'ip', 'order']

    class ServerDelete(DeleteView):
        model = Server
        success_url = reverse_lazy('server_list')


### Define the URLs

We need to define app URLs in the file __servers/urls.py:

    from django.conf.urls import patterns, url

    from servers import views

    urlpatterns = patterns('',
    url(r'^$', views.ServerList.as_view(), name='server_list'),
    url(r'^new$', views.ServerCreate.as_view(), name='server_new'),
    url(r'^edit/(?P<pk>\d+)$', views.ServerUpdate.as_view(), name='server_edit'),
    url(r'^delete/(?P<pk>\d+)$', views.ServerDelete.as_view(), name='server_delete'),
    )

This URLs wouldn't work unless you include the **servers/urls.py** in the main URLs file **django_proj_name/urls.py**:

    urlpatterns = patterns('',
    :
    url(r'^servers/', include('servers.urls')),
    :
    )


### Templates

**templates/servers/server_form.html** This file will be used by Edit and Update views:

    <form method="post">{% csrf_token %}
        {{ form.as_p }}
        <input type="submit" value="Submit" />
    </form>

**templates/servers/server_list.html** This file will be used by the ListView:

    <h1>Servers</h1>
    <ul>
        {% for server in object_list %}
        <li>{{ server.name }}  :  
        <a href="{% url "server_edit" server.id %}">{{ server.ip }}</a>
        <a href="{% url "server_delete" server.id %}">delete</a>
        </li>
        {% endfor %}
    </ul>

    <a href="{% url "server_new" %}">New</a>

**templates/servers/server_confirm_delete.html** This file will be used by DeleteView:

    <form method="post">{% csrf_token %}
        Are you sure you want to delete "{{ object }}" ?
        <input type="submit" value="Submit" />
    </form>


### Function Based View Version

The example above uses **Class Based Views** (or CBV for short) to implement the views, what I will cover now is how to implement the same functionality but with **Function Based Views** i.e. using functions instead of classes, we will be using the same templates:

**servers/views.py**:

    from django.shortcuts import render, redirect, get_object_or_404
    from django.forms import ModelForm

    from servers.models import Server

    class ServerForm(ModelForm):
        class Meta:
            model = Server
            fields = ['name', 'ip', 'order']

    def server_list(request, template_name='servers/server_list.html'):
        servers = Server.objects.all()
        data = {}
        data['object_list'] = servers
        return render(request, template_name, data)

    def server_create(request, template_name='servers/server_form.html'):
        form = ServerForm(request.POST or None)
        if form.is_valid():
            form.save()
            return redirect('server_list')
        return render(request, template_name, {'form':form})

    def server_update(request, pk, template_name='servers/server_form.html'):
        server = get_object_or_404(Server, pk=pk)
        form = ServerForm(request.POST or None, instance=server)
        if form.is_valid():
            form.save()
            return redirect('server_list')
        return render(request, template_name, {'form':form})

    def server_delete(request, pk, template_name='servers/server_confirm_delete.html'):
        server = get_object_or_404(Server, pk=pk)    
        if request.method=='POST':
            server.delete()
            return redirect('server_list')
        return render(request, template_name, {'object':server})

**servers/urls.py**:

    from django.conf.urls import patterns, url

    from servers import views

    urlpatterns = patterns('',
    url(r'^$', views.server_list, name='server_list'),
    url(r'^new$', views.server_create, name='server_new'),
    url(r'^edit/(?P<pk>\d+)$', views.server_update, name='server_edit'),
    url(r'^delete/(?P<pk>\d+)$', views.server_delete, name='server_delete'),
    )

p.s. personally I prefer using FBV over CBV, the article <a href="http://lukeplant.me.uk/blog/posts/djangos-cbvs-were-a-mistake/">Django's CBVs were a mistake</a> explains why.

