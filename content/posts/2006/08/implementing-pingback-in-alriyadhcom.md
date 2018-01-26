---
title: Implementing Pingback in alriyadh.com
author: Rayed
type: post
date: 2006-08-25T14:53:02+03:00
categories:
  - alriyadh.com
  - Blog
  - PHP
wordpress_id: 264

---
<blockquote cite="http://en.wikipedia.org/wiki/Pingback"><p>Pingback is a method for Web authors to request notification when somebody links to one of their documents. This enables authors to keep track of who is linking to, or referring to their articles.</p></blockquote>
<p>Implementing Pingback feature is very easy, you need to add the following code to your template:<br />
<code><br />
&lt;link rel="pingback" href="http://www.alriyadh.com/php/xmlrpc/" /&gt;<br />
</code></p>
<p>This code will make other blogging software notify your software that it is linking to it, It do this by sending &#8220;pingback.ping&#8221; XML-RPC request to the given URL, when you get the notification you can add it to the database, email it, or do what ever you want with it.</p>
<p>This is a sample code of the XML-RPC server using <a href="http://scripts.incutio.com/xmlrpc/">Incutio XML-RPC Library for PHP</a>, It accept &#8220;pingback.ping&#8221; request, send an email to you with the source URL, and destionation URL:<br />
<code><br />
< ?php
  include 'IXR_Library.inc.php';
  
  function pingBack($args) {
    $body = 'Ping from: '.$args[0]
           .'Ping to: ' . $args[1];
    mail('user@domain.com', 'Subject: Ping Back', $body);
    return 'Thank you'; 
  
  }
  
  $server = new IXR_Server(array(
      'pingback.ping' => 'pingBack',<br />
  ));</p>
<p>?><br />
</code></p>
<p>TrackBack is another protocol that is similar to Pingback, may be I&#8217;ll write something for it as well.</p>
<p>Wikipedia links:</p>
<ul>
<li><a href="http://en.wikipedia.org/wiki/Pingback">Pingback</a></li>
<li><a href="http://en.wikipedia.org/wiki/TrackBack">TrackBack</a></li>
</ul>
<p>I&#8217;ve added Pingback to <a href="http://www.alriyadh.com/">alriyadh.com</a> and I&#8217;ll update with any intersting stuff.</p>
<p><b>Update:</b> So far and after 36 ours I didn&#8217;t get any pingback 🙂<br />
<b>Update:</b> I got my first pingback from SaudiGeek: <a href="http://www.saudigeek.com/?p=124">http://www.saudigeek.com/?p=124</a>, SaudiGeek I hope you don&#8217;t mind using you in my example.</p>
