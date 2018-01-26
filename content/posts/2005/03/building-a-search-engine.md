---
title: Building a search engine
author: Rayed
type: post
date: 2005-03-08T01:43:00+03:00
categories:
  - Uncategorized
wordpress_id: 101

---
<div style="clear:both;"></div>
<p>Currently I am working on a search engine for a large website, the search engine is based on PHP+MySQL.</p>
<p>You may wonder why not use LIKE in SQL for searching! Of course LIKE will work with few documents, but how about tens of thousand of documents it would be very slow, since the DBMS would have top scan all reconrds one by one in your database to find the word you are looking for.</p>
<p>I decided to work on my own search engine after testing few applications, mainly <a href="http://search.mnogo.ru/">mnogosearch</a>, and <a href="http://www.phpdig.net/">PHPDig</a>, both program didn&#8217;t fit my need exactly, plus the support for Arabic wasn&#8217;t that good either.</p>
<p>The engine should index 45000 document, currently the indexer can index 70 documents per second, which mean it would take 10 hours to index the whole thing.</p>
<p>The search engine needs a lot of tuning, like removing common words, removing Arabic Harkat, and Hamzat, hopefully I will end up with a nice reusable search engine.<br />I&#8217;ll post a link when we put in production.</p>
<div style="clear:both; padding-bottom: 0.25em;"></div>
