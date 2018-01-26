---
title: Supporting right to left writing (for Arabic) in WordPress (Updated)
author: Rayed
type: post
date: 2012-06-15T19:31:18+03:00
categories:
  - Uncategorized
wordpress_id: 1018

---
<p><strong>UPDATE: I found an easier way to do the same thing <a href="http://rayed.com/wordpress/?p=1290">Check it out</a></strong></p>
<p>This post is an update of previous old post: <a href="http://rayed.com/wordpress/?p=303">Supporting right to left writing (for Arabic) in WordPress</a></p>
<p>In my blog I write in both languages English and Arabic, but I have to switch text direction from the template default English direction “Left to Right” to Arabic “Right to Left”.<br />
One way do to it is to add HTML tags in each Arabic entry.</p>
<p>Another way to do it is to utilize WordPress “Custom Fields” feature, WordPress allows you to add custom fields to any entry, so I add a new custom field to my Arabic entries, the key will be “wp_direction” and the value will be “rtl”.</p>
<p><a href="http://rayed.com/wordpress/wp-content/uploads/2012/06/Screen-shot-2012-09-02-at-5.39.23-PM.png"><img src="http://rayed.com/wordpress/wp-content/uploads/2012/06/Screen-shot-2012-09-02-at-5.39.23-PM-300x199.png" alt="" title="Custom Fields " width="300" height="199" class="alignnone size-medium wp-image-1043" srcset="https://rayed.com/wordpress/wp-content/uploads/2012/06/Screen-shot-2012-09-02-at-5.39.23-PM-300x199.png 300w, https://rayed.com/wordpress/wp-content/uploads/2012/06/Screen-shot-2012-09-02-at-5.39.23-PM-450x300.png 450w, https://rayed.com/wordpress/wp-content/uploads/2012/06/Screen-shot-2012-09-02-at-5.39.23-PM.png 551w" sizes="(max-width: 300px) 100vw, 300px" /></a></p>
<p>Then from your favorite template modify:<br />
<code><br />
content.php<br />
content-single.php<br />
</code></p>
<p>Change the beginning of the file to look something like this:<code><br />
&lt;?php<br />
/**<br />
 * The default template for displaying content<br />
 *<br />
 * @package WordPress<br />
 * @subpackage Twenty_Eleven<br />
 * @since Twenty Eleven 1.0<br />
 */<br />
$direction = get_post_custom_values('wp_direction');<br />
$style_dir = $direction[0]=='rtl'? ' style="direction:rtl;" ' : '';<br />
?></p>
<p>&lt;article id="post-< ?php the_ID(); ?>" < ?php post_class(); ?> < ?= $style_dir ?> ><br />
</code></p>
<p>You can also use “$style_dir” value to switch the text direction on all relevant tags.</p>
<p><strong>Note: These step tested with WordPress 3.0+ </strong></p>
