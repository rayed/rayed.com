---
title: New Thunderbird checklist
author: Rayed
type: post
date: 2006-08-15T11:42:12+03:00
categories:
  - Life
  - SAUDI NET
  - UNIX
wordpress_id: 260

---
<p><b>Check all IMAP folders:</b><br />
By default Thunderbird only checks the inbox for new messages, but since we use server side filter emails don&#8217;t have to go to inbox and sometimes go directly to destionation folder.<br />
Fortunaltely Tunderbird can be configured to check all folders, but it has to be done manually, put the follwoing lines in &#8220;user.js&#8221;:<br />
<code><br />
// Download mail from all accounts on startup<br />
user_pref("mail.check_all_imap_folders_for_new", true);<br />
</code><br />
The file doesn&#8217;t exists by default so you need to create it in your &#8220;profile&#8221; filder, this link will help you to locate your &#8220;profile&#8221; folder:<br />
<a href="http://www.mozilla.org/support/thunderbird/edit#profile">http://www.mozilla.org/support/thunderbird/edit#profile</a></p>
<p><b>Disable return receipts:</b><br />
I don&#8217;t why people use this feature it is bit annoying, so I usually disable requesting and replying to &#8220;return receipt&#8221;:<br />
Edit -> Options -> Composition -> General -> Return Receipt<br />
Uncheck &#8220;When sending message, always request a return receipt&#8221;<br />
and select &#8220;Never send return receipt&#8221;</p>
<p><b>Customize Encoding</b><br />
Open new Compose windows (CTRL+M)<br />
Options->Character Encoding->Customize list<br />
I always delete everything and keep &#8220;Arabic (Windows-1256)&#8221; , and &#8220;UTF-8&#8221;</p>
<p>Then to change the default character encoding:<br />
Tools->Options->Dispaly->Fonts<br />
Select &#8220;Arabic (Windows-1256)&#8221; as default for incoming and outgoing emails.<br />
Check &#8220;Apply the default character encoding to all incoming messages.&#8221;<br />
Check &#8220;Use the default chacter encoding in replies&#8221;</p>
<p><b>Update:</b><br />
Install BiDu plugin <a href="https://addons.mozilla.org/en-US/thunderbird/addon/310">BiDi plugin</a>, to support right to left editing.</p>
