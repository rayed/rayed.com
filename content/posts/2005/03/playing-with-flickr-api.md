---
title: Playing with Flickr API
author: Rayed
type: post
date: 2005-03-20T01:38:00+03:00
categories:
  - Uncategorized
wordpress_id: 98

---
<div style="clear:both;"></div>
<p>Flickr has really amazing web service API, they support many transports REST, SOAP, and XML-RPC. I had some idea about SOAP, and XML-RPC, and never worked with REST, it turned out as the best and the simplest one of them.</p>
<p>All you need is API KEY which is a key you use every time you call a function, it is used by Flickr for statistics, you can get it from here <a href="http://www.flickr.com/services/api/key.gne">Get a key</a>, it is only one form, and you will get the key instantly.</p>
<p>This is a sample REST request:<br /><a href= "http://www.flickr.com/services/rest/?method=flickr.people.findByUsername&#038;api_key=e8fdab62c5f8dd2b458b393598773d04" >/services/rest/?method=flickr.people.findByUsername&#038;api_key=e8fda&#8230;</a></p>
<p>Give it a try it is really simple API, and simple interface.</p>
<div style="clear:both; padding-bottom: 0.25em;"></div>
