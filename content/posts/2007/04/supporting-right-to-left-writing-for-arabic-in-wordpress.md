---
title: Supporting right to left writing (for Arabic) in WordPress
author: Rayed
type: post
date: 2007-04-06T12:08:30+03:00
categories:
  - Blog
  - PHP
wordpress_id: 303

---
<p><strong>UPDATE: I found an easier way to do the same thing <a href="http://rayed.com/wordpress/?p=1290">Check it out</a></strong></p>
<p>In my blog I write in both languages English and Arabic, but I have to switch text direction from the template default English direction &#8220;Left to Right&#8221; to Arabic &#8220;Right to Left&#8221;.<br />
One way do to it is to add HTML tags in each Arabic entry.<br />
Another way to do it is to utilize WordPress &#8220;Custom Fields&#8221; feature, WordPress allows you to add custom fields to any entry, so I add a new custom field to my Arabic entries, the key will be &#8220;wp_direction&#8221; and the value will be &#8220;rtl&#8221;.<br />
Then from my template I modify &#8220;index.php&#8221; and add the following code inside the posts loop:<br />
<code><br />
< ?php
$direction = get_post_custom_values('wp_direction');
$style_dir = $direction[0]=='rtl'? ' style="direction:rtl;" ' : '';
?><br />
</code><br />
Then use &#8220;$style_dir&#8221; value to switch the text direction on all relevant tags.</p>
<p><strong>UPDATE:</strong> As Steve stated in his comment, you might want to change &#8220;single.php&#8221; template also. Thanks Steve.</p>
