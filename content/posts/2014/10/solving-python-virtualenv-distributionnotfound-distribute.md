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
After upgrading my Ubuntu machine from 12.04 to 14.04 I had this error on virtualenv wrapper:

<!--more-->

    stevedore.extension distribute
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

After some investigation I found out the cause of the error, it seems that I've installed virtualenv-wrapper using pip and not Ubuntu apt-get, so when I installed it using apt-get it conflicted with the pip installation.

### Solution

- Remove virtualenvwrapper Ubuntu package: `sudo aptitude remove virtualenvwrapper`
- Remove virtualenvwrapper pip package: `sudo pip uninstall virtualenvwrapper virtualenv-clone virtualenv stevedore`
- Reinstall virtualenvwrapper Ubuntu package: `sudo aptitude install virtualenvwrapper`
