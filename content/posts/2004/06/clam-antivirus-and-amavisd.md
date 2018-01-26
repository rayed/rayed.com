---
title: Clam AntiVirus and amavisd
author: Rayed
type: post
date: 2004-06-28T11:25:51+03:00
categories:
  - Uncategorized
wordpress_id: 44

---
<div style="clear:both;"></div>
<p>After installing amavisd you need to edit the confiuration file to change some of the settings:<br /><code># vi /usr/local/etc/amavisd.conf<br />:<br />$mydomain = 'yourdomain.com';<br />:<br />$final_spam_destiny = D_PASS;</code><br />You also need to enable clamav section, then restart:<br /><code># /usr/local/etc/rc.d/amavisd.sh restart</code></p>
<p>To allow amavisd-new to work with clamav you need to run clamav using the same user:<br /><code># vi /usr/local/etc/clamav.conf<br />... change user to:<br /> User vscan<br /># /usr/local/etc/rc.d/clamav-clamd.sh restart</code></p>
<div style="clear:both; padding-bottom: 0.25em;"></div>
