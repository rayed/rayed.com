---
title: FreeBSD port for PHP supports dynamic extensions (update)
author: Rayed
type: post
date: 2004-11-01T01:36:45+03:00
categories:
  - Uncategorized
wordpress_id: 80

---
<div style="clear:both;"></div>
<p>Few months ago I wrote about php4-extensions as the way to install other PHP modules, php4-extensions is a meta port which mean it isn&#8217;t a real port, it is a port used to install other ports.<br />So when you try to install php4-extensions, and selected MySQL, and XML extensions, it will install the following ports:<code><br /> /usr/ports/databases/php4-mysql<br /> /usr/ports/textproc/php4-xml<br /></code>and you can uninstall them separately.<br />This solve alot of issue for me, previously when I want to upgrade MySQL I have to uninstall PHP completly, and reinstall it again of course this mean upgrading all port used by PHP, which create a miss.<br />Now, I can reinstall only PHP MySQL extension only.</p>
<div style="clear:both; padding-bottom: 0.25em;"></div>
