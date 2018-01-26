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
<p>Everytime I work with Image or File fields in Django I forget some tiny detail that waste 10-20 minutes until I remember what was I missing, I always say I will remeber it next time but I never do! so I made a list of common errors I keep doing while working with Image/File fields:</p>
<p><strong>For complete working project: <a href="https://github.com/rayed/dj-imagefield-example">https://github.com/rayed/dj-imagefield-example</a></strong></p>
<h2>Setting MEDIA_URL and MEDIA_ROOT</h2>
<p>Make sure you set proper values for MEDIA_URL and MEDIA_ROOT in your settings.py, e.g. I use the following structure:<br />
<code></p>
<pre>
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
</pre>
<p></code><br />
I would put the following settings (for both MEDIA and STATIC files):<br />
<code></p>
<pre>
STATIC_URL = '/static/'
STATIC_ROOT = os.path.join(BASE_DIR, '..','www','static')
MEDIA_URL = '/media/'
MEDIA_ROOT = os.path.join(BASE_DIR, '..','www','media')
</pre>
<p></code></p>
<h2>Make sure uploaded files are accessible in development server</h2>
<p>Serving uploaded files (media) is the job of the web server and not Django, but to ease the development process I usually make Django serve it in debug mode.</p>
<p>This is done by adding the following at the end of your main urls.py:<br />
<code></p>
<pre>
from django.conf import settings
from django.conf.urls.static import static
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
</pre>
<p></code></p>
<h2>HTML forms changes</h2>
<p>Make sure you have <strong>enctype=&#8221;multipart/form-data&#8221;</strong> in your form tag, i.e.:<br />
<code></p>
<pre>
&lt;form method="post" enctype="multipart/form-data"></pre>
<p></code><br />
Instead of:<br />
<code></p>
<pre>
&lt;form method="post">
</pre>
<p></code></p>
<h2>Don&#8217;t forget request.FILES</h2>
<p>I always forget to include &#8220;request.FILES&#8221; in my ModelForms, and I always get &#8220;This field is required&#8221; error message!<br />
<code></p>
<pre>
def author_create(request, template_name='author/form.html'):
    form = ImageForm(request.POST or None, <strong>request.FILES or None</strong>)
    if form.is_valid():
        form.save()
        return redirect('author:home')
    return render(request, template_name, {'form':form})    
</pre>
<p></code></p>
<h2>ImageField requires Imaging library</h2>
<p>If you want to use Django built in ImageField you have to install <a href="https://pillow.readthedocs.org/">Pillow</a> Imaging library! FileField doesn&#8217;t needed it though.</p>
<h2>View the image</h2>
<p>Just a reminder that you can access the image URL in your template like so:<br />
<code></p>
<pre>
&lt;img src="{{ author.image.url }}"  />
</pre>
<p></code></p>
