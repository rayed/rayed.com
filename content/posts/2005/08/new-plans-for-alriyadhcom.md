---
title: New plans for alriyadh.com
author: Rayed
type: post
date: 2005-08-05T01:03:13+03:00
categories:
  - alriyadh.com
  - PHP
wordpress_id: 136

---
<p>When I started building <a href="http://alriyadh.com/">alriyadh.com</a> website I decided to generate all pages as static HTML files, I relied heavily on Server Side Includes (SSI) to build complex pages.</p>
<p>The main reason for this decision was the fact that the server was very slow on processing PHP files, espcially with a site with high load.</p>
<p>Generating static HTML files has its advantages but it also had many problems:</p>
<ul>
<li>Regenerate everytime you want to test a change</li>
<li>Changing the design will cause regenrating the whole website, which could take forever.</li>
<li>Generating complex pages is very hard, I had to rely on SSI.</li>
<li>What to do with pages that change frequently, e.g. pages with comments.</li>
<li>When importing old data, you need to generate them as well.</li>
<li>Static HTML files performance advantage for frequently used data, like todays issue, but for old issues it just take a lot of disk space.</li>
</ul>
<p>Soon I&#8217;ll start testing dynamicly generated of pages with these points in mind:</p>
<ul>
<li>Use mod_rewrite to keep the userfriendly urls, i.e. instead of &#8220;section.php?id=4&#038;issue=3424&#8221; it will be &#8220;/2005/08/04/section.main.html&#8221;, it wil still use PHP and generate it on demand.</li>
<li>Use caching to improve performance and decrease load.</li>
<li>Utlize PHPAccelerator to improve PHP performance.</li>
</ul>
