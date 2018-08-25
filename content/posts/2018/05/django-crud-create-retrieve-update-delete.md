---
title: Django CRUD (Create, Retrieve, Update, Delete)
author: Rayed
type: post
date: 2018-05-20T14:52:00+03:00
categories:
  - Uncategorized
tags:
  - django
  - python
wordpress_id: 1266
aliases: [/posts/2013/07/django-crud-create-retrieve-update-delete/]
---

One of the most common task when developing web application is to write 
create, read, update and delete functionality (CRUD) for each table you have.

In this post I briefly cover the step needed to create a CRUD app in
 Django, the steps we will need are:

<!--more-->

- Install Django & start new project
- Create an App
- Create the Model
- Create the Admin Interface (optional)
- Create the View
- Define the URLs (i.e. URL to View mapping)
- Create the Templates

**Note:** These step are updated for Django 2 which requires Python 3, if you don't 
have Python 3 installed on your system you will find needed steps for your OS here:
[How To Install and Set Up a Local Programming Environment for Python 3](https://www.digitalocean.com/community/tutorial_series/how-to-install-and-set-up-a-local-programming-environment-for-python-3)


### Install Django and Start New Project

First we need to install Django and start new Django project, I'll name it my_proj:

    pip install django
    django-admin startproject my_proj
    cd my_proj


### Create new App

From the Django project directory we will create the new app called "books" to store our books collection:

    ./manage.py startapp books

We will also need to register the new app in our Django project, add the app "books" to the INSTALLED_APPS in your `my_proj/settings.py`:

    INSTALLED_APPS = (
        :
        'books',
        :
    )


### Create the Model

The model file would be `books/models.py`:

    from django.db import models
    from django.urls import reverse

    class Book(models.Model):
        name = models.CharField(max_length=200)
        pages = models.IntegerField()

        def __str__(self):
            return self.name

        def get_absolute_url(self):
            return reverse('book_edit', kwargs={'pk': self.pk})

After defining the model you need to provision it to the database:

    ./manage.py makemigrations
    ./manage.py migrate

To create the table for the new model.



### Admin Interface (optional)

Django will give you free CRUD interface from the admin site, just define the file `books/admin.py` as:

    from django.contrib import admin
    from books.models import Book

    admin.site.register(Book)


### The Views

We will use Django Class-based views to create our app pages, the file `books/views.py` would look like:

    from django.http import HttpResponse
    from django.views.generic import ListView, DetailView
    from django.views.generic.edit import CreateView, UpdateView, DeleteView
    from django.urls import reverse_lazy

    from books.models import Book

    class BookList(ListView):
        model = Book

    class BookView(DetailView):
        model = Book

    class BookCreate(CreateView):
        model = Book
        fields = ['name', 'pages']
        success_url = reverse_lazy('book_list')

    class BookUpdate(UpdateView):
        model = Book
        fields = ['name', 'pages']
        success_url = reverse_lazy('book_list')

    class BookDelete(DeleteView):
        model = Book
        success_url = reverse_lazy('book_list')
        

### Define the URLs

We need to define app URLs in the file `books/urls.py` (create the file):

    from django.urls import path

    from . import views

    urlpatterns = [
        path('', views.BookList.as_view(), name='book_list'),
        path('view/<int:pk>', views.BookView.as_view(), name='book_view'),
        path('new', views.BookCreate.as_view(), name='book_new'),
        path('view/<int:pk>', views.BookView.as_view(), name='book_view'),
        path('edit/<int:pk>', views.BookUpdate.as_view(), name='book_edit'),
        path('delete/<int:pk>', views.BookDelete.as_view(), name='book_delete'),
    ]

This URLs wouldn't work unless you include the `books/urls.py` in the main URLs file `my_proj/urls.py`:

    # Make sure you import "include" function
    from django.urls import include

    urlpatterns = [
        :
        path('books/', include('books.urls')),
        :
    ]


### Templates

`books/templates/books/book_list.html` This file will be used by the ListView:

    <h1>Books</h1>

    <table border="1">
    <thead>
        <tr>
        <th>Name</th>
        <th>Pages</th>
        <th>View</th>
        <th>Edit</th>
        <th>Delete</th>
        </tr>
    </thead>
    <tbody>
        {% for book in object_list %}
        <tr>
        <td>{{ book.name }}</td>
        <td>{{ book.pages }}</td>
        <td><a href="{% url "book_view" book.id %}">view</a></td>
        <td><a href="{% url "book_edit" book.id %}">edit</a></td>
        <td><a href="{% url "book_delete" book.id %}">delete</a></td>
        </tr>
        {% endfor %}
    </tbody>
    </table>

    <a href="{% url "book_new" %}">New</a>

`books/templates/books/book_detail.html` This file will be used by detail views:

    <h1>Book Details</h1>
    <h2>Name: {{object.name}}</h2>
    Pages: {{ object.pages }}


`books/templates/books/book_form.html` This file will be used by Edit and Update views:

    <h1>Book Edit</h1>
    <form method="post">{% csrf_token %}
        {{ form.as_p }}
        <input type="submit" value="Submit" />
    </form>

`books/templates/books/book_confirm_delete.html` This file will be used by DeleteView:

    <h1>Book Delete</h1>
    <form method="post">{% csrf_token %}
        Are you sure you want to delete "{{ object }}" ?
        <input type="submit" value="Submit" />
    </form>


### Test It

So everything in place, now we can run the development web server:

    ./manage.py runserver

Then access it through a web browser <http://localhost:8000/books/>

To test the admin interface we need to create a user first:

    ./manage.py createsuperuser

and access it <http://localhost:8000/admin/>


### Function Based View Version

The example above uses `Class Based Views` (or CBV for short) to implement the views, what I will cover now is how to implement the same functionality but with `Function Based Views` i.e. using functions instead of classes, we will be using the same templates:

`books/views.py`:

    from django.shortcuts import render, redirect, get_object_or_404
    from django.forms import ModelForm

    from books.models import Book

    class BookForm(ModelForm):
        class Meta:
            model = Book
            fields = ['name', 'pages']

    def book_list(request, template_name='books/book_list.html'):
        book = Book.objects.all()
        data = {}
        data['object_list'] = book
        return render(request, template_name, data)

    def book_view(request, pk, template_name='books/book_detail.html'):
        book= get_object_or_404(Book, pk=pk)    
        return render(request, template_name, {'object':book})

    def book_create(request, template_name='books/book_form.html'):
        form = BookForm(request.POST or None)
        if form.is_valid():
            form.save()
            return redirect('book_list')
        return render(request, template_name, {'form':form})

    def book_update(request, pk, template_name='books/book_form.html'):
        book= get_object_or_404(Book, pk=pk)
        form = BookForm(request.POST or None, instance=book)
        if form.is_valid():
            form.save()
            return redirect('book_list')
        return render(request, template_name, {'form':form})

    def book_delete(request, pk, template_name='books/book_confirm_delete.html'):
        book= get_object_or_404(Book, pk=pk)    
        if request.method=='POST':
            book.delete()
            return redirect('book_list')
        return render(request, template_name, {'object':book})

`books/urls.py`:

    from django.urls import path

    from books import views

    urlpatterns = [
        path('', views.book_list, name='book_list'),
        path('view/<int:pk>', views.book_view, name='book_view'),
        path('new', views.book_create, name='book_new'),
        path('edit/<int:pk>', views.book_update, name='book_edit'),
        path('delete/<int:pk>', views.book_delete, name='book_delete'),
    ]

You clone the complete example from <https://github.com/rayed/django_crud>


p.s. personally I prefer using FBV over CBV, the article <a href="http://lukeplant.me.uk/blog/posts/djangos-cbvs-were-a-mistake/">Django's CBVs were a mistake</a> explains why.


**UPDATE:** You might be interested in [Django CRUD Parent/Child Edition](/posts/2016/01/django-crud-parentchild-edition/)
