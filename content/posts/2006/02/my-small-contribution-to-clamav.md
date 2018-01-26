---
title: My tiny contribution to ClamAV
author: Rayed
type: post
date: 2006-02-26T15:40:12+03:00
categories:
  - SAUDI NET
  - UNIX
wordpress_id: 214

---
<p><a href="http://www.clamav.net/">ClamAV</a> is an open source Anti Virus software for UNIX systems, we use it here in <a href="http://www.saudi.net.sa/">SAUDI NET</a> to stop Virus in email message it stops thousands of viruses  everyday, I also use it in our <a href="http://myweb.saudi.net.sa/">personal hosting</a> service that we provide for our customers, unfortunately some customers upload virus intentionally and unintentionally, so I installed ClamAV to scan and delete viruses.</p>
<p>Last week I noticed one of our trouble making customers uploading sospious files, I ran &#8220;clamscan&#8221; on the user directory but it didn&#8217;t detect it, when I tried to download it my PC anti-virus software &#8220;MicroTrend&#8221; stopped the download warning me about the Virus. So I went home and downloaded it again and scanned it using Norton AV, it didn&#8217;t detect it either! </p>
<p>I submitted the file ClamAV <a href="http://cgi.clamav.net/sendvirus.cgi">virus database</a>, it is very simple form where you need to upload the infected file, and some basic information about it.</p>
<p>Today I recived and email telling me that the virus is added to ClamAV database. I went to myweb server, updated the virus database:<br />
<code># freshclam<br />
ClamAV update process started at Sun Feb 26 15:15:12 2006<br />
main.cvd is up to date (version: 36, sigs: 44686, f-level: 7, builder: tkojm)<br />
Downloading daily.cvd [*]<br />
daily.cvd updated (version: 1304, sigs: 1000, f-level: 7, builder: ccordes)<br />
Database updated (45686 signatures) from database.clamav.net<br />
Clamd successfully notified about the update.<br />
</code></p>
<p>Then I ran &#8220;clamscan&#8221; again:<br />
<code># clamscan --remove -ir .<br />
./xxxx.scr: Trojan.Downloader.Small-1060 FOUND<br />
./xxxx.scr: Removed<br />
</code></p>
<p>It feels good 🙂</p>
