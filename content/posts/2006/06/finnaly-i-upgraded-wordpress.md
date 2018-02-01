---
title: Finnaly I upgraded WordPress
author: Rayed
type: post
date: 2006-06-07T00:19:35+03:00
categories:
  - alriyadh.com
  - Blog
  - Life
  - PHP
wordpress_id: 241

---
Today I had to finish writing some code for <a href="http://www.alriyadh.com/worldcup/">Alriyadh Worldcup</a> web site, and I was expecting it to take at least 5 to 6 hours, and it had to be finished today, so I planned all my evening for that coding session

Fortunately I finished the job in 2 hours, and I had some extra time in my hand, so I decided to do something I planned to do for very long time, upgrade WordPress, so I sat down and upgrade it from version 1.5 to the latest version, alhamdu lelah the upgrade process was very smoth, althogh some features didn&#8217;t work, mainy the rich text editing feature.

Update: I found the problem with rich editing, it turned out that many directories had the wrong permission (700), after I fixed the permisions it worked fine, here is the command to find all the directory and change the permisions:

    find . -type d -exec chmod 755 {} \;

and since I host my blog inside Saudi arabia I have to put my proxy setting in the file &#8220;wp-includes/class-snoopy.php&#8221;. (See 
[Fixing WordPress dashboard](/posts/2005/06/fixing-wordpress-dashboard/))

Rich editing looks nice but it seems limited, e.g. I wanted to write a command using the code tag, but no button for it! I guess I can use the HTML editing feature, it also take long time to appear.

But overall the new WordPress looks very elegant and modern, unlike the old WordPress which looks very basic.

