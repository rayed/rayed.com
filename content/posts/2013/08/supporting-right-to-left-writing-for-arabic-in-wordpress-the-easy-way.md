---
title: 'Supporting Right-to-Left (for Arabic) in WordPress: the Easy Way'
author: Rayed
type: post
date: 2013-08-02T09:28:16+03:00
categories:
  - Uncategorized
tags:
  - css
  - html
  - wordpress
wordpress_id: 1290

---
This post is an update of previous old post: <a href="http://rayed.com/wordpress/?p=1018">Supporting right to left writing (for Arabic) in WordPress</a>

<!--more-->

In my blog I write in both languages English and Arabic, but I have to switch text direction from the template default English direction “Left to Right” to Arabic “Right to Left”.

One way do to it is to add HTML tags in each Arabic entry, you can also add a "Custom Field" in the post and add special processing instruction in your template to add the needed "RTL" HTML tags.

I found an easier way to do it, I noticed that WordPress new templates add an HTML class to your post for each "Tag" you add in your post, e.g. if you add a tag named "python" in the post you will get ".tag-python" in your HTML, so I decided to utilise this facility by adding the tag "arabic" to any post I want to view in Arabic, and I added the needed CSS attributes to the class ".tag-arabic".

You can even change you CSS from the admin interface, from "Appearance > Edit CSS" then added the following CSS snippet:

    .tag-arabic {
      direction: rtl;
      text-align: right;
      font-size: 130%;
    }

Note: I enlarged the font size in Arabic posts for readability, Arabic font don't render very well in small sizes.

