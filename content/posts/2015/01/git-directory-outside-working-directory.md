---
title: Git directory outside working directory
author: Rayed
type: post
date: 2015-01-15T13:13:03+03:00
categories:
  - Uncategorized
tags:
  - apache
  - git
  - nginx
  - PHP
  - web
wordpress_id: 1751

---
<p>I have an old PHP website that I wanted to have its code/content versioned with Git, normally Git setup the repo directory in the &#8220;.git&#8221; directory inside the working directory, but I faced a problem, if the working directory is accessible from the web server it means &#8220;.git&#8221; is also accessible too.</p>
<p>Luckily git have an option to have the repo directory located somewhere else using the GIT_DIR environment variable, so here what I did:</p>
<pre><code>
$ vi .profile
GIT_DIR=/home/rayed/my_website_git
GIT_WORK_TREE=/var/www/my_website
export GIT_DIR
export GIT_WORK_TREE
</code></pre>
<p>You notice that the web site is located in &#8220;/var/www/my_website&#8221; but the repo is located under totally different directory &#8220;/home/rayed/my_website_git&#8221;, so the web server can&#8217;t access it by mistake.</p>
