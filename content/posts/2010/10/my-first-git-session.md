---
title: My first Git Session
author: Rayed
type: post
date: 2010-10-31T08:42:27+03:00
categories:
  - Uncategorized
tags:
  - code
  - git
  - linux
  - osx
  - UNIX
wordpress_id: 789

---
<p>This guide for my own reference please don&#8217;t rely on it, for a better introduction check out <a href="http://gitref.org/">Git Reference</a> website. Basic concept and terminologies, Git have 3 logical places:</p>
<ul>
<li>Working Area: normal directory where you edit your project.</li>
<li>Staging Area: Think of the staging as your project state before you start your coding session, after each coding session you add your changes to staging area using &#8220;git add filename&#8221; or &#8220;git add .&#8221;</li>
<li>Snapshot Area: After multiple coding sessions you would finish a logical change, e.g. adding commenting system in web site, next you need to store a snapshot of your project after these changes, you would do that with &#8220;git commit&#8221;</li>
</ul>
<p>Setting the environment:</p>
<pre><code>git config --global user.name "Rayed Alrashed"
git config --global user.email "my@email"
git config --global color.ui true
</code></pre>
<p>Start versioning a project:</p>
<pre><code>cd my_project
make clean
vi .gitignore  # files you want Git to ignore, e.g. log, tmp, binaries
git init           # Initalize Git 
git add .        # Add All files to Git tracking
git commit    # Initial commit, get a snapshot of the project
</code></pre>
<p>Typical workflow:</p>
<pre><code>cd my_project
:
vi README
git status -s            # Get the status of files changed
git add README      # Add README to staging area
:
git commit -m "Describe your change"        # Make a snapshot of the staging area
</code></pre>
