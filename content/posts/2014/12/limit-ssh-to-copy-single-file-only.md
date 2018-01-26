---
title: Limit SSH to Copy a Single File Only
author: Rayed
type: post
date: 2014-12-26T13:51:51+03:00
categories:
  - Uncategorized
tags:
  - linux
  - scp
  - security
  - ssh
wordpress_id: 1733

---
<p>I want to allow host-2 to copy a file securely from host-1, so the easiest way is to use &#8220;scp&#8221; command which use &#8220;ssh&#8221; as a transport to copy the file.</p>
<p>If you want to do it manually it is straight forward &#8220;scp&#8221; invocation:</p>
<pre><code>host-2$ scp host-1:data.csv .</code></pre>
<p>But if you want to automate it you have to use &#8220;ssh&#8221; keys, but this means leaving a private ssh key on host-2 that can access host-1 without any restriction, i.e.</p>
<pre><code>host-2$ ssh host-1  # FULL ACCESS NO PASSWORD NEEDED!!</code></pre>
<p>A better way is to generate a new ssh-key on host-2, like:</p>
<pre><code>host-2$ ssh-keygen
:
host-2$ ls ~/.ssh/id_rsa*
id_rsa
id_rsa.pub
host-2$ cat id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDHBoO5JciwnRKWzbmZiZ68J7Vouim+ZUNvmsXYeCFa6TDGTmG9Wh1KhAAgQDqTuwL9BcgbOM2qiwOlLMREtH6LYLbbp9RIBIGNb0a8UL3Fka++vziHkTgaqPJ2Uq0Qd8J0oZCqseBQqSMlebO4BxOYuRMqEFn7ETR5N+SM/hq5PeuS5SVGnleJOqaO8Cq5AcoIdlYeRXjDIFw9x7DugHKP4uBTr2o+lft7seyHjYOmrWiX0+GFiDsdTzqIMC+Px3pqY8Hcd4DC2lmYDJCDG7Js3zzvzp8Xs6sBEwqZpECh8TmXZxl5/OHt8XtVCJs0lfqiHhQWFIlsYqPg+4AsjiUP
</code></pre>
<p>Then add the the key to host-1 authorized_keys file with one small change:</p>
<pre><code>host-1$ vi ~/.ssh/authorized_keys
:
<span style="color:green;">command="scp -f data.csv"</span> ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDHBoO5JciwnRKWzbmZiZ68J7Vouim+ZUNvmsXYeCFa6TDGTmG9Wh1KhAAgQDqTuwL9BcgbOM2qiwOlLMREtH6LYLbbp9RIBIGNb0a8UL3Fka++vziHkTgaqPJ2Uq0Qd8J0oZCqseBQqSMlebO4BxOYuRMqEFn7ETR5N+SM/hq5PeuS5SVGnleJOqaO8Cq5AcoIdlYeRXjDIFw9x7DugHKP4uBTr2o+lft7seyHjYOmrWiX0+GFiDsdTzqIMC+Px3pqY8Hcd4DC2lmYDJCDG7Js3zzvzp8Xs6sBEwqZpECh8TmXZxl5/OHt8XtVCJs0lfqiHhQWFIlsYqPg+4AsjiUP
</code></pre>
<p>Notice the command part, which limit the given key to a given command.</p>
<p><strong>NOTE: the public key is the same one generated from previous step on host-2</strong></p>
<p>Now if you try to access the machine it will fail.</p>
<pre><code>host-2$ ssh host-1
Connection to host-1 closed.
</code></pre>
<p>Even if you try to copy another file it will download the file you specify in the authorized_keys:</p>
<pre><code>host-2$ scp host-1:data.xml .
data.csv    100%
</code></pre>
<p>Notice that it downloaded the data.csv and not data.xml!</p>
