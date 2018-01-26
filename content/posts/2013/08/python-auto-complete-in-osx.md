---
title: Python auto complete in OSX
author: Rayed
type: post
date: 2013-08-26T00:35:35+03:00
categories:
  - Uncategorized
tags:
  - osx
  - python
wordpress_id: 1372

---
<p>If you run Python shell in OSX you notice the auto completion functionality isn&#8217;t working, this is caused by Apple decision not to ship GNU readline and instead they use libedit (BSD license), to fix the problem I used the following snippet:</p>
<p><code></p>
<pre>
import readline
import rlcompleter
if 'libedit' in readline.__doc__:
    readline.parse_and_bind("bind ^I rl_complete")
else:
    readline.parse_and_bind("tab: complete")
</pre>
<p></code></p>
<p>Source:<br />
<a href="http://stackoverflow.com/a/7116997">http://stackoverflow.com/a/7116997</a></p>
