---
title: Install Python Image Library (PIL) on OSX
author: Rayed
type: post
date: 2013-11-15T15:14:18+03:00
categories:
  - Uncategorized
tags:
  - image
  - mac
  - osx
  - pil
  - python
wordpress_id: 1433

---
<p><a href="http://en.wikipedia.org/wiki/Python_Imaging_Library">PIL</a> or Python Imaging Library is a library that allows you to manipulate images in Python programming language, trying to install &#8220;PIL&#8221; using &#8220;pip&#8221; tool won&#8217;t work perfectly so here is how to proper installation.</p>
<h2>Install Brew</h2>
<p><a href="http://brew.sh/">Brew</a> is a package management system that simplifies the installation of software on Mac OS X, you can install it easily with the following command:</p>
<pre><code>ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
</code></pre>
<h2>Install Pil</h2>
<p>Actually we will install &#8221;pillow&#8221; a fork of &#8221;pil&#8221;:</p>
<pre><code>brew install samueljohn/python/pillow
</code></pre>
<h2>Configure your Python Path</h2>
<p>To make PIL available to Python we add its path to PYTHONPATH variable:</p>
<pre><code>vi ~/.bash_profile
PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
export PYTHONPATH
</code></pre>
<h2>Check it</h2>
<p>To test if you have PIL installed:</p>
<pre><code>python -c "import PIL.Image"
</code></pre>
<p>You shouldn&#8217;t get any errors.</p>
