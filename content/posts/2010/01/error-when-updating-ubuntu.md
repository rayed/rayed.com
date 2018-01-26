---
title: Error when updating Ubuntu
author: Rayed
type: post
date: 2010-01-15T11:04:43+03:00
categories:
  - Uncategorized
tags:
  - linux
  - ubuntu
  - update
wordpress_id: 734

---
<p>Lately I migrated all of my server to <a href="http://www.ubuntu.com/">Ubuntu</a> server, what I really loved about it the easy of updating the system, all I need to is:<br />
<code><br />
$ sudo aptitude update   # to update packages meta data<br />
$ sudo aptitude safe-upgrade  # to perform the actual upgrade<br />
</code></p>
<p>But sometimes on of the package information meta data files get corrupted, and I will get this error:<br />
<code><br />
$ sudo aptitude update<br />
:<br />
W: A error occurred during the signature verification. The repository is not updated and the previous index files will be used.GPG error: http://security.ubuntu.com hardy-security Release: The following signatures were invalid: BADSIG 40976EAF437D05B5 Ubuntu Archive Automatic Signing Key &lt;ftpmaster@ubuntu.com&gt;</p>
<p>W: You may want to run apt-get update to correct these problems<br />
</code></p>
<p>To solve this problem, try:<br />
<code><br />
sudo rm /var/lib/apt/lists/partial/*<br />
sudo apt-get update -o Acquire::http::No-Cache=true<br />
</code></p>
