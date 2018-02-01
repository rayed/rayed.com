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
<strong>UPDATE: I found an easier way to do the same thing [Check it out](/posts/2013/08/supporting-right-to-left-writing-for-arabic-in-wordpress-the-easy-way/)</strong>

In my blog I write in both languages English and Arabic, but I have to switch text direction from the template default English direction "Left to Right" to Arabic "Right to Left".

One way do to it is to add HTML tags in each Arabic entry.

Another way to do it is to utilize WordPress "Custom Fields" feature, WordPress allows you to add custom fields to any entry, so I add a new custom field to my Arabic entries, the key will be "wp_direction" and the value will be "rtl".

Then from my template I modify "index.php" and add the following code inside the posts loop:

    < ?php
    $direction = get_post_custom_values('wp_direction');
    $style_dir = $direction[0]=='rtl'? ' style="direction:rtl;" ' : '';
    ?>

Then use "$style_dir" value to switch the text direction on all relevant tags.

<strong>UPDATE:</strong> As Steve stated in his comment, you might want to change "single.php" template also. Thanks Steve.

