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
Summary: Always use `render` and not `render_to_response`
In Django you have more than one way to return a response, but many times I get confused between `render` and `render_to_response`, render_to_response seems shorter, so why not use it!

<!--more-->

To explain let's assume simple posts page:

    def article_list(request, template_name='article/list.html'):
        posts = Post.objects.all()
        # DON'T USE
        return render_to_response(template_name, {'posts': posts})


In this example you will be able to access "posts" in your template, but unfortunately you will not have access to other important variables from other Middlewares, most importantly: user, csrf_token, and messages. To make "render_to_response" pass all these parameters you must send a "context_instance" like this:

    return render_to_response(template_name, {'posts': posts}, context_instance=RequestContext(request))


Not so short after all, compare to "render" version:

    # USE THIS :)
    return render(request, template_name, {'posts': posts})


In fact "render" is always shorter than "render_to_response", even without the "context_instance":

    return render(request, template_name, {'posts': posts})
    ... vs ...
    return render_to_response(template_name, {'posts': posts})


