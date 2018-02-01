---
title: Supporting right to left writing (for Arabic) in WordPress (Updated)
author: Rayed
type: post
date: 2012-06-15T19:31:18+03:00
categories:
  - Uncategorized
wordpress_id: 1018

---
**UPDATE: I found an easier way to do the same thing [Check it out](/posts/2013/08/supporting-right-to-left-writing-for-arabic-in-wordpress-the-easy-way/)**

This post is an update of previous old post: [Supporting right to left writing (for Arabic) in WordPress](/posts/2007/04/supporting-right-to-left-writing-for-arabic-in-wordpress/)

In my blog I write in both languages English and Arabic, but I have to switch text direction from the template default English direction “Left to Right” to Arabic “Right to Left”.
One way do to it is to add HTML tags in each Arabic entry.

Another way to do it is to utilize WordPress “Custom Fields” feature, WordPress allows you to add custom fields to any entry, so I add a new custom field to my Arabic entries, the key will be “wp_direction” and the value will be “rtl”.

<a href="/static/uploads/2012/06/Screen-shot-2012-09-02-at-5.39.23-PM.png"><img src="/static/uploads/2012/06/Screen-shot-2012-09-02-at-5.39.23-PM-300x199.png" alt="" title="Custom Fields " width="300" height="199" class="alignnone size-medium wp-image-1043" srcset="/static/uploads/2012/06/Screen-shot-2012-09-02-at-5.39.23-PM-300x199.png 300w, /static/uploads/2012/06/Screen-shot-2012-09-02-at-5.39.23-PM-450x300.png 450w, /static/uploads/2012/06/Screen-shot-2012-09-02-at-5.39.23-PM.png 551w" sizes="(max-width: 300px) 100vw, 300px" /></a>

Then from your favorite template modify:

    content.php
    content-single.php

Change the beginning of the file to look something like this:

    <?php
    /**
    * The default template for displaying content
    *
    * @package WordPress
    * @subpackage Twenty_Eleven
    * @since Twenty Eleven 1.0
    */
    $direction = get_post_custom_values('wp_direction');
    $style_dir = $direction[0]=='rtl'? ' style="direction:rtl;" ' : '';
    ?>

    <article id="post-< ?php the_ID(); ?>" < ?php post_class(); ?> < ?= $style_dir ?> >

You can also use “$style_dir” value to switch the text direction on all relevant tags.

**Note: These step tested with WordPress 3.0+**

