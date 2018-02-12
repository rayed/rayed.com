---
title: Improving thumbnails quality
author: Rayed
type: post
date: 2007-02-05T12:51:45+03:00
categories:
  - alriyadh.com
  - Blog
  - PHP
wordpress_id: 294

---
Inpired by <a href="http://colorspretty.blogspot.com/2007/01/flickrs-dirty-little-secre_117020899505299548.html">Flickr&#8217;s Dirty Little Secret</a> post, about how <a href="http://www.flickr.com/">Flickr</a> thumbnails make the photo prettier than the original photo.

The article suggest that Flick sharpen the image before it resize it.

So I did my own test, this the result and you are the judge:

<img src="/static/uploads/old/2007-02-05/img-small.jpg" /> <img src="/static/uploads/old/2007-02-05/img-med.jpg" />

Image 1, normal resize.

Image 2, sharpen before resize.

<img src="/static/uploads/old/2007-02-05/img2.jpg" />

<img src="/static/uploads/old/2007-02-05/img2-sharp.jpg" />

Sharpened and saturated +100:

<img src="/static/uploads/old/2007-02-05/img2-sharp-sat.jpg" />

All I need to know is how to do it from inside PHP.

