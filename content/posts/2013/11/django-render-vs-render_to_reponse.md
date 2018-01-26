---
title: Django “render” vs “render_to_response”
author: Rayed
type: post
date: 2013-11-19T01:37:29+03:00
categories:
  - Uncategorized
tags:
  - django
  - python
wordpress_id: 1445

---
<p>Summary: Always use <strong>render</strong> and not <strong>render_to_response</strong></p>
<p>In Django you have more than one way to return a response, but many times I get confused between <strong>render</strong> and <strong>render_to_response</strong>, render_to_response seems shorter, so why not use it!</p>
<p>To explain let&#8217;s assume simple posts page:</p>
<pre><code>def article_list(request, template_name='article/list.html'):
    posts = Post.objects.all()
    # DON'T USE
    return render_to_response(template_name, {'posts': posts})
</code></pre>
<p>In this example you will be able to access &#8220;posts&#8221; in your template, but unfortunately you will not have access to other important variables from other Middlewares, most importantly: user, csrf_token, and messages. To make &#8220;render_to_response&#8221; pass all these parameters you must send a &#8220;context_instance&#8221; like this:</p>
<pre><code>return render_to_response(template_name, {'posts': posts}, context_instance=RequestContext(request))
</code></pre>
<p>Not so short after all, compare to &#8220;render&#8221; version:</p>
<pre><code># USE THIS :)
return render(request, template_name, {'posts': posts})
</code></pre>
<p>In fact &#8220;render&#8221; is always shorter than &#8220;render_to_response&#8221;, even without the &#8220;context_instance&#8221;:</p>
<pre><code>return render(request, template_name, {'posts': posts})
... vs ...
return render_to_response(template_name, {'posts': posts})
</code></pre>
