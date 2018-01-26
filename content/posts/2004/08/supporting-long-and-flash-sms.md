---
title: Supporting long, and flash SMS
author: Rayed
type: post
date: 2004-08-02T04:27:38+03:00
categories:
  - Uncategorized
wordpress_id: 65

---
<div style="clear:both;"></div>
<p>Today Abdullah Aldosari my coworker insisted on working on long SMSs, he kept dreaming of them the last couple of days, so we sat together today, and we figured out how to do it.<br />It was fairly simple, in fact I found an old code that I wrote for sending operator logos which use this feature! Abdullah also searched for the way to send flash SMS, it was even simpler, all you need is to set a flag when sending the SMS and that&#8217;s it.<br />These new features will be introduced to <a href="http://www.saudi.net.sa/">SAUDI NET</a> <a href="http://my.saudi.net.sa/">portal</a> after proper testing (i.e. tomorrow 🙂<br />We are using a protocol called <a href="http://www.smsforum.net/">SMPP</a> it is used to communicate with the SMS Center, the SMPP client library we are using is currently written in <a href="http://www.python.org/">Python</a> language, I am thinking of rewriting it in PHP  as soon as I find a good way to convert between character sets.</p>
<div style="clear:both; padding-bottom: 0.25em;"></div>
