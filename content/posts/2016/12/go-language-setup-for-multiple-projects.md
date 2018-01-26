---
title: Go Language Setup for Multiple Projects
author: Rayed
type: post
date: 2016-12-29T14:29:45+03:00
categories:
  - Uncategorized
tags:
  - development
  - go
  - golang
  - linux
wordpress_id: 1992

---
<p>When working with <a href="https://golang.org/">Go</a> language you must setup the GOPATH environment variable, but soon you will face two problems:</p>
<ul>
<li>Each project should have its own Go dependencies and its own Git code repo, so putting your source under GOPATH would be problematic.</li>
<li>When working with &#8220;Atom&#8221; with &#8220;Go Plus&#8221; plugin, it needs to install several Go packages which would pollute your own source.</li>
</ul>
<p>To solve both problems I added the following to my &#8220;.bash_login&#8221;:<br />
<code></p>
<pre>
export GOPATH=$HOME/go
alias atom='PATH=$PATH:$HOME/go/bin GOPATH=$HOME/go:$GOPATH atom'
gpp() {
        export GOPATH=`pwd`
}
</pre>
<p></code></p>
<p>It perform the following:</p>
<ul>
<li>Set a default GOPATH to $HOME/go_sandbox for testing small Go projects</li>
<li>Set an alias for &#8220;atom&#8221; to add an extra dir in GOPATH and PATH, so whatever GO Plus plugin add won&#8217;t be add to your current GOPATH</li>
<li>Setup a &#8220;gpp&#8221; function to quickly change GOPATH to current directory</li>
</ul>
