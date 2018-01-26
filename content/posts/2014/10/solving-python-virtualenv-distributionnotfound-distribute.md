---
title: 'Solving Python virtualenv “DistributionNotFound: distribute”'
author: Rayed
type: post
date: 2014-10-29T12:44:10+03:00
categories:
  - Uncategorized
tags:
  - pip
  - python
  - ubuntu
  - virtualenv
wordpress_id: 1704

---
<p>After upgrading my Ubuntu machine from 12.04 to 14.04 I had this error on virtualenv wrapper:<br />
<code></p>
<pre>stevedore.extension distribute
Traceback (most recent call last):
  File "/usr/local/lib/python2.7/dist-packages/stevedore/extension.py", line 75, in _load_plugins
    invoke_kwds,
  File "/usr/local/lib/python2.7/dist-packages/stevedore/extension.py", line 87, in _load_one_plugin
    plugin = ep.load()
  File "/usr/lib/python2.7/dist-packages/pkg_resources.py", line 2087, in load
    if require: self.require(env, installer)
  File "/usr/lib/python2.7/dist-packages/pkg_resources.py", line 2100, in require
    working_set.resolve(self.dist.requires(self.extras),env,installer)))
  File "/usr/lib/python2.7/dist-packages/pkg_resources.py", line 628, in resolve
    raise DistributionNotFound(req)
DistributionNotFound: distribute
</pre>
<p></code></p>
<p>After some investigation I found out the cause of the error, it seems that I&#8217;ve installed virtualenv-wrapper using pip and not Ubuntu apt-get, so when I installed it using apt-get it conflicted with the pip installation.</p>
<h2>Solution</h2>
<ul>
<li>Remove virtualenvwrapper Ubuntu package: <code>sudo aptitude remove virtualenvwrapper</code></li>
<li>Remove virtualenvwrapper pip package: <code>sudo pip uninstall virtualenvwrapper virtualenv-clone virtualenv stevedore</code></li>
<li>Reinstall virtualenvwrapper Ubuntu package: <code>sudo aptitude install virtualenvwrapper</code></li>
</ul>
