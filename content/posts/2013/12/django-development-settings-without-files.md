---
title: Django Multiple Settings with Single File
author: Rayed
type: post
date: 2013-12-12T14:16:10+03:00
categories:
  - Uncategorized
tags:
  - django
  - python
wordpress_id: 1493

---
<p>Instead of having multiple settings files one for production and one for development and so on, I prefer to use an &#8220;if&#8221; statement with environment variable:</p>
<pre><code>ENV = os.environ.get('DJANGO_ENV', '')
print "==== Active Env: [%s]  ====" % (ENV)    
if ENV == "dev":
    # DEBUG
    DEBUG = True
    TEMPLATE_DEBUG = DEBUG
else:
    DEBUG = False
    TEMPLATE_DEBUG = False
</code></pre>
<p>Then from your &#8220;.bashrc&#8221; file:</p>
<pre><code>export DJANGO_ENV=dev
</code></pre>
