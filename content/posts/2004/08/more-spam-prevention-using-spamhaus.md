---
title: More spam prevention using Spamhaus
author: Rayed
type: post
date: 2004-08-14T12:02:28+03:00
categories:
  - Uncategorized
wordpress_id: 62

---
<div style="clear:both;"></div>
<p>Today I started using <a href="http://www.spamhaus.org/">Spamhaus</a> to help prevent spam, I use it now in addition to <a href="http://www.spamcop.net">Spamcop</a>.<br />It was triggered by many spam emails coming from the same range of IPs, so I tested it with Spamhaus and it blocked it.</p>
<p>Here is the code to add in <a href="http://www.postfix.org/">Postfix</a> main.cf file:<code><br />smtpd_client_restrictions =<br />        permit_mynetworks<br />        check_client_access hash:/usr/local/etc/postfix/client_access<br />        <b>reject_rbl_client sbl.spamhaus.org</b><br />        reject_rbl_client bl.spamcop.net<br />        permit<br /></code></p>
<div style="clear:both; padding-bottom: 0.25em;"></div>
