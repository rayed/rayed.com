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
<p>This post is an update of previous old post: <a href="http://rayed.com/wordpress/?p=1018">Supporting right to left writing (for Arabic) in WordPress</a></p>
<p>In my blog I write in both languages English and Arabic, but I have to switch text direction from the template default English direction “Left to Right” to Arabic “Right to Left”.<br />
One way do to it is to add HTML tags in each Arabic entry, you can also add a &#8220;Custom Field&#8221; in the post and add special processing instruction in your template to add the needed &#8220;RTL&#8221; HTML tags.</p>
<p>I found an easier way to do it, I noticed that WordPress new templates add an HTML class to your post for each &#8220;Tag&#8221; you add in your post, e.g. if you add a tag named &#8220;python&#8221; in the post you will get &#8220;.tag-python&#8221; in your HTML, so I decided to utilise this facility by adding the tag &#8220;arabic&#8221; to any post I want to view in Arabic, and I added the needed CSS attributes to the class &#8220;.tag-arabic&#8221;.</p>
<p>You can even change you CSS from the admin interface, from &#8220;Appearance &gt; Edit CSS&#8221; then added the following CSS snippet:</p>
<pre><code>.tag-arabic {
	direction: rtl;
	text-align: right;
	font-size: 130%;
}
</code></pre>
<p>Note: I enlarged the font size in Arabic posts for readability, Arabic font don&#8217;t render very well in small sizes.</p>
