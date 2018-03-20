---
title: "Goodbye Wordpress, Hello Hugo"
date: 2018-02-03T21:11:35+03:00
draft: true
---

In June 2005 [I moved my blog](/posts/2005/06/moving-my-blog-from-blogger-to-wordpress/) from [Blogger.com](https://www.blogger.com/) to self hosted Wordpress blog.

Wordpress served me well the last 13 years, but during that time I had some issues that made the experience less enjoyable.

With the rise of static site generators I was tempted to migrate, but when I tried it, it was much harder that I though, not running the generator but mainly migrating my old contents.

But early this I migrated my whole blog to use [Hugo](https://gohugo.io/), it wasn't easy and it took few days of research and trial and errors but I finally managed to do it!

Here I'll explain my motives for migrations, and also my experience of migrating to Hugo!

<!--more-->

## Why Migrate


### Fixing My Old URL Mistake

When I installed Wordpress for the first time, I was careless! I put my blog (i.e. my whole website) under /wordpress path, and to make matters worse I used the query string format for the URLs (e.g. /wordpress/?p=1051) instead of date and name (e.g. /posts/2013/08/japan-tokyo/)

I hated that format so much but it was very late, and very cumbersome to change!


### Ditching the LAMP Stack

PHP was my language of choice when it comes to web application development, but not any more, I mainly moved to using [Django](https://www.djangoprojects.com/), same thing apply to MySQL which I replaced with Postgres, and I also replaced Apache with Nginx! so running a full LAMP stack just to support my blog wasn't a good idea anymore!


### Updates, updates, updates!!

Wordpress came along way when it comes to the software update process, but still I hated it, and I couldn't manage to convince my self to use the auto update stuff.


### Moving to Free Hosting?

I haven't ditch my VPS (virtual private server) yet, I like to keep it around to test a lot of things that need decent bandwidth (try downloading Docker images from 4G connection!), but having a static site make it easier to move and may be ditch the whole server soon.

You can host your website easily with [Github](https://pages.github.com/) and for free!


### Backups ... Not Anymore!

Since everything in static site generator is a file, it is easy to but under `git` and keep a version on any git hosting service like github or bitbucket, and as added bonus you would get automatic versioning of your contents!


#### Markdown

To me Markdown simplify the editing process tremendously and makes it easier to focus on your thought instead of how to write it, it also easier to edit and modify, and all you need is good old text editor!

I tried a Markdown plugin with Wordpress, but it added more confusion and gave unpredictable results.


### Security

Over the past 13 years I had 3 minor security issues, but hopefully with a static site I wouldn't need to worry as much.


## How I moved

### Exporting the Content

I started with (wordpress-to-hugo-exporter)(https://github.com/SchumacherFM/wordpress-to-hugo-exporter) WordPress plugin, it works by allowing you to download all the content of your website as Hugo ready directory. But I had to make some changes to make it work per my requiremnt:

- I had to change the default dates from GMT based to use my own timezone.
- I added a new field in each post [Front Matter](https://gohugo.io/content-management/front-matter/), the field name is "wordpress_id" this will make it easier to make a map between old URLs and new URLs, by using a simple `grep` command.
- I disabled PHP Markdownify function and extracted the data as is. Hugo can display HTML content just fine, and Markdownify broke many pages!
- By default the plugin put all posts in a single directory, but I had so many posts to fit in a single directory, so I replaced it with a hierarchical structure by year and month.


### Exporting the Comments

Since Hugo is a static site generator it doesn't support any type of dynamic behavior like adding and viewing comments, but luckily [disqus](https://disqus.com/) provides comment management system by simply adding few lines of JavaScript.

Disqus can import all the comments from your WordPress export file very easily, but how I can tell Disqus about the URL change, luckily they have a migration tool just for this scenario.

I used the following command to extract a URL migration map, by utilizing the "wordpress_id" I've created during the content migration from the previous step:

    grep -r "wordpress_id" content/posts | \
    sed 's/^content//' | \
    sed 's#.md:wordpress_id: #/,#' | \
    awk -F, ' { printf("https://rayed.com/wordpress/?p=%s,https://rayed.com%s\n", $2, $1) }' > \
    disqus_map.out.csv

I had a problem that I didn't anticpate or solve yet, all Arabic names in the comments got incorrectly converted! I haven't researched it yet, and I thought I would edit manually later.


### Exporting the Images

Over the past 13 years, I've used many ways to organize my images, so I had to do major organization to my archive, and I used `grep` again to find incorrect links and fix them manually.


### Correcting Internal Links

I've written a small PHP redirection script from old /wordpress links to the new website using the same mapping I used for Disqus, so this step wasn't really mandatory, but I went through old links anyway and corrected them manually. 