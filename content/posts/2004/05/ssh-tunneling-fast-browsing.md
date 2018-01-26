---
title: ssh tunneling = fast browsing
author: Rayed
type: post
date: 2004-05-17T11:36:32+03:00
categories:
  - Uncategorized
wordpress_id: 29

---
<div style="clear:both;"></div>
<p>A while ago I tried tunneling proxy conection though ssh, you asked why &#8230; because ssh have a neat compression feature, it will compress all ssh communication between your client and the ssh server, and by tunneling HTTP proxy trafic through ssh you can speed up HTML page loading time, you can really see the difference.<br />Any way I had a problem of having to run ssh client every time I want to use the Internet, even when you want to check one small thing, it was kind of anoying to change the proxy from the localhost (thought tunneling) and connecting directly to the <a href="http://www.saudi.net.sa/">SAUDI NET</a> proxy server.<br />Today I invested sometime to build small proxy auto configuration script, that will try to use the local proxy (compressed &#038; tunneled) and if it fails it will try to connect directly to the proxy, here is the script, give it a try it really makes thing FAST.</p>
<pre style="background:#EEE;"><br />// proxy.js save this file in localy and <br />// point your browser auto config to it<br />function FindProxyForURL(url, host) {<br /><br />  if (isPlainHostName(host) || <br />      dnsDomainIs(host, ".saudi.net.sa")) return "DIRECT";<br /><br />  return "PROXY localhost:8080; PROXY proxy.saudi.net.sa:8080;";<br /><br />}<br /></pre>
<div style="clear:both; padding-bottom: 0.25em;"></div>
