---
title: PHP Accelerator is awesome
author: Rayed
type: post
date: 2005-03-13T07:08:00+03:00
categories:
  - MySQL
  - Uncategorized
wordpress_id: 99

---
<div style="clear:both;"></div>
<p>I have a server with <a href="http://phpadsnew.com/two/">PHPAdsNew</a> installed serving around 20 requests per second serving a really busy web site.</p>
<p>Few days ago the admins for that website doubled the number of ads per page, and the server stopped responding most of the day 🙁</p>
<p>I installed PHP Accelerator to make it faster to serve the those ads, but it didn&#8217;t help that much, I tried every trick I know to maximize MySQL performance (although it didn&#8217;t have any load in the first place) nothing worked.</p>
<p>Today, I sat down and played a little with PHP Accelerator, I moved the cache directory from /tmp (mounted on swap) to a regular directory, and the amazing thing happened, the CPU utilization drop from 100% to 50%.</p>
<p>Then I tried the command &#8220;phpa_cache_admin -mv&#8221; to realize that PHP Accelerator is working without shared memory enabled, I enabled it and restarted Apache, the utilization drop to only 10% 🙂</p>
<p>I did all of these changes after the peak hour, I wonder how it will perform tomorrow in the peak hour, I&#8217;ll post my results tomorrow.</p>
<p>UPDATE: Peak hour update, very smooth as if there aren&#8217;t any requests, CPU utilization 40% 🙂</p>
<div style="clear:both; padding-bottom: 0.25em;"></div>
