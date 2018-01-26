---
title: SMPP client rewritten in PHP
author: Rayed
type: post
date: 2004-08-03T02:04:33+03:00
categories:
  - Uncategorized
wordpress_id: 64

---
<p>Today I ported my Python SMPP client library to PHP, I had to redesign the whole library because the old design was very bad, and with the new design it became very small, and trivial library.</p>
<p>Most of my work was on a library to convert between window-1256 charset used by most Arabic computers, to UTF-16 (big endian) used by GSM phones.</p>
<p>The new SMPP library supports long and flash messages, you can try it from <a href="http://www.saudi.net.sa/">SAUDI NET</a> <a href="http://my.saudi.net.sa/">Portal</a>.</p>
<p><strong>update:</strong> You can download the library from:<br />
<a href="http://rayed.com/wordpress/?page_id=406">SMPP PHP Client</a></p>
