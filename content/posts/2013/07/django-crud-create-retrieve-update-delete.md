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
<p><strong>UPDATE 1</strong>: The main example use <strong>Class Based Views</strong>, I also added <strong>Function Based Views</strong> version of the same functionality.</p>
<p><strong>UPDATE 2</strong>: I added a new example application with user access, user must login and each user has his own list.<br />
<strong>Sample Code:</strong> You can download a sample application from <a href="https://github.com/rayed/django_crud">https://github.com/rayed/django_crud</a></p>
<p><strong>UPDATE 3</strong>: You might be interested in <a href="https://rayed.com/wordpress/?p=1873">Django CRUD Parent/Child Edition</a></p>
<p>In this post I briefly cover the step needed to create a CRUD app in Django, the steps we will need are:</p>
<ul>
<li>Create an App</li>
<li>Create the Model</li>
<li>Create the Admin Interface (optional)</li>
<li>Create the View</li>
<li>Define the URLs (i.e. URL to View mapping)</li>
<li>Create the Templates</li>
</ul>
<p><!--more--></p>
<h2>Create new App</h2>
<p>From the Django project directory we will create the new app called &#8220;servers&#8221; to store our servers information:</p>
<pre><code> ./manage.py startapp servers
</code></pre>
<p>We will also need to register the new app in our Django project, add the app &#8216;server&#8217; to the INSTALLED_APPS in your <strong>django_proj_name/settings.py</strong>:</p>
<pre><code>INSTALLED_APPS = (
  :
  'servers',
  :
)
</code></pre>
<h2>Create the Model</h2>
<p>The model file would be <strong>servers/models.py</strong>:</p>
<pre><code>from django.db import models
from django.core.urlresolvers import reverse

class Server(models.Model):
    name = models.CharField(max_length=200)
    ip = models.GenericIPAddressField()
    order = models.IntegerField()

    def __unicode__(self):
        return self.name

    def get_absolute_url(self):
        return reverse('server_edit', kwargs={'pk': self.pk})
</code></pre>
<p>After defining the model you need to provision it to the database:</p>
<pre><code>./manage.py makemigrations
./manage.py migrate
</code></pre>
<p>To create the table for the new model.</p>
<h2>Admin Interface (optional)</h2>
<p>Django will give you free CRUD interface from the admin site, just define the file <strong>servers/admin.py</strong> as:</p>
<pre><code>from django.contrib import admin
from servers.models import Server

admin.site.register(Server)
</code></pre>
<h2>The Views</h2>
<p>We will use Django Class-based views to crete our app pages, the file <strong>servers/views.py</strong> would look like:</p>
<pre><code>from django.http import HttpResponse
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
</code></pre>
<h2>Define the URLs</h2>
<p>We need to define app URLs in the file __servers/urls.py:</p>
<pre><code>from django.conf.urls import patterns, url

from servers import views

urlpatterns = patterns('',
  url(r'^$', views.ServerList.as_view(), name='server_list'),
  url(r'^new$', views.ServerCreate.as_view(), name='server_new'),
  url(r'^edit/(?P&lt;pk&gt;\d+)$', views.ServerUpdate.as_view(), name='server_edit'),
  url(r'^delete/(?P&lt;pk&gt;\d+)$', views.ServerDelete.as_view(), name='server_delete'),
)
</code></pre>
<p>This URLs wouldn&#8217;t work unless you include the <strong>servers/urls.py</strong> in the main URLs file <strong>django_proj_name/urls.py</strong>:</p>
<pre><code>urlpatterns = patterns('',
  :
  url(r'^servers/', include('servers.urls')),
  :
)
</code></pre>
<h2>Templates</h2>
<p><strong>templates/servers/server_form.html</strong> This file will be used by Edit and Update views:</p>
<pre><code>&lt;form method="post"&gt;{% csrf_token %}
    {{ form.as_p }}
    &lt;input type="submit" value="Submit" /&gt;
&lt;/form&gt;
</code></pre>
<p><strong>templates/servers/server_list.html</strong> This file will be used by the ListView:</p>
<pre><code>&lt;h1&gt;Servers&lt;/h1&gt;
&lt;ul&gt;
    {% for server in object_list %}
    &lt;li&gt;{{ server.name }}  :  
    &lt;a href="{% url "server_edit" server.id %}"&gt;{{ server.ip }}&lt;/a&gt;
    &lt;a href="{% url "server_delete" server.id %}"&gt;delete&lt;/a&gt;
    &lt;/li&gt;
    {% endfor %}
&lt;/ul&gt;

&lt;a href="{% url "server_new" %}"&gt;New&lt;/a&gt;
</code></pre>
<p><strong>templates/servers/server_confirm_delete.html</strong> This file will be used by DeleteView:</p>
<pre><code>&lt;form method="post"&gt;{% csrf_token %}
    Are you sure you want to delete "{{ object }}" ?
    &lt;input type="submit" value="Submit" /&gt;
&lt;/form&gt;
</code></pre>
<h2>Function Based View Version</h2>
<p>The example above uses <strong>Class Based Views</strong> (or CBV for short) to implement the views, what I will cover now is how to implement the same functionality but with <strong>Function Based Views</strong> i.e. using functions instead of classes, we will be using the same templates:</p>
<p><strong>servers/views.py</strong>:</p>
<pre><code>from django.shortcuts import render, redirect, get_object_or_404
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
</code></pre>
<p><strong>servers/urls.py</strong>:</p>
<pre><code>from django.conf.urls import patterns, url

from servers import views

urlpatterns = patterns('',
  url(r'^$', views.server_list, name='server_list'),
  url(r'^new$', views.server_create, name='server_new'),
  url(r'^edit/(?P&lt;pk&gt;\d+)$', views.server_update, name='server_edit'),
  url(r'^delete/(?P&lt;pk&gt;\d+)$', views.server_delete, name='server_delete'),
)
</code></pre>
<p>p.s. personally I prefer using FBV over CBV, the article <a href="http://lukeplant.me.uk/blog/posts/djangos-cbvs-were-a-mistake/">Django&#8217;s CBVs were a mistake</a> explains why.</p>
