---
title: CodeIgniter setup tips
author: Rayed
type: post
date: 2008-02-11T14:26:59+03:00
categories:
  - MySQL
  - PHP
wordpress_id: 355

---
<ul>
<li>Fix mod_rewrite to have clean URLs, and get rid of &#8220;index.php&#8221; part.</li>
<li>Edit &#8220;config/config.php&#8221; and change the following:<br />
<code><br />
// Setup your base URL<br />
$config['base_url']="http://rayed.com/ci/";<br />
// No need for index.php<br />
$config['index_page'] = "";<br />
// Remove AUTO and Put PATH_INFO<br />
// this will allows you to pass variables as URL<br />
// segments or Query string "?id=1"<br />
$config['uri_protocol'] = "PATH_INFO";<br />
</code>
</li>
<li>Setup your database configuration &#8220;config/database.php&#8221;</li>
<li>Auto connect to database, edit &#8220;config/autoload.php&#8221;: <br />
<code>$autoload['libraries'] = array('database');</code>
</li>
<li>Edit &#8220;config/routes.php&#8221; to change default controller:<br />
<code>$route['default_controller'] = "users";</code>
</li>
</ul>
