---
title: Django Image and File Field Caveats
author: Rayed
type: post
date: 2015-04-19T00:49:36+03:00
categories:
  - Uncategorized
tags:
  - django
  - media
  - python
wordpress_id: 1773

---
Everytime I work with Image or File fields in Django I forget some tiny detail that waste 10-20 minutes until I remember what was I missing, I always say I will remeber it next time but I never do! so I made a list of common errors I keep doing while working with Image/File fields:

*For complete working project: (https://github.com/rayed/dj-imagefield-example)*

### Setting MEDIA_URL and MEDIA_ROOT

Make sure you set proper values for MEDIA_URL and MEDIA_ROOT in your settings.py, e.g. I use the following structure:

    my_new_site/
        apps/
        apps/
            settings.py
        gallery/
        blog/
        www/
        media/
        static/
        requirements.txt

I would put the following settings (for both MEDIA and STATIC files):

    STATIC_URL = '/static/'
    STATIC_ROOT = os.path.join(BASE_DIR, '..','www','static')
    MEDIA_URL = '/media/'
    MEDIA_ROOT = os.path.join(BASE_DIR, '..','www','media')


### Make sure uploaded files are accessible in development server

Serving uploaded files (media) is the job of the web server and not Django, but to ease the development process I usually make Django serve it in debug mode.
This is done by adding the following at the end of your main urls.py:

    from django.conf import settings
    from django.conf.urls.static import static
    if settings.DEBUG:
        urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)


### HTML forms changes

Make sure you have <strong>enctype="multipart/form-data"</strong> in your form tag, i.e.:

    <form method="post" enctype="multipart/form-data">

Instead of:

    <form method="post">


### Don't forget request.FILES

I always forget to include "request.FILES" in my ModelForms, and I always get "This field is required" error message!

    def author_create(request, template_name='author/form.html'):
        form = ImageForm(request.POST or None, request.FILES or None)
        if form.is_valid():
            form.save()
            return redirect('author:home')
        return render(request, template_name, {'form':form})    


### ImageField requires Imaging library

If you want to use Django built in ImageField you have to install [Pillow](https://pillow.readthedocs.org/) Imaging library! FileField doesn't needed it though.

### View the image

Just a reminder that you can access the image URL in your template like so:

    <img src="{{ author.image.url }}"  />


