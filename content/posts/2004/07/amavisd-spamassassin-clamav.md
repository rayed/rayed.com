---
title: Amavisd + Spamassassin + ClamAV
author: Rayed
type: post
date: 2004-07-12T08:45:13+03:00
categories:
  - Uncategorized
wordpress_id: 57

---
<div style="clear:both;"></div>
<p>Installing amavisd+Spamassassin+clamav<br /><code><br /># cd /usr/ports/security/amavisd-new/<br /># make install<br /># cd /usr/ports/security/clamav/<br /># make install<br /></code></p>
<p>Updating ClamAV virus defintation, every hour!:<br /><code><br /># vi /usr/local/etc/freshclam.conf<br />... HTTPProxyServer proxy.saudi.net.sa<br />... HTTPProxyPort 8080<br /># freshclam<br /># crontab -e<br />... 43 * * * * /usr/local/bin/freshclam --quiet<br /></code></p>
<p>Changing clamav setting to work as vscan user, same as amavisd:<br /><code><br /># vi /usr/local/etc/clamav.conf<br />... # Change User to match amavid user<br />... User vscan<br /># chown -R vscan:vscan /var/run/clamav<br /></code></p>
<p>Configuraing amavisd:<br /><code><br /># cp /usr/local/etc/amavisd.conf-dist /usr/local/etc/amavisd.conf<br /># vi /usr/local/etc/amavisd.conf<br />... $mydomain = 'rayed.com';<br />... $virus_admin = "rayed\@$mydomain";<br />... $spam_admin = "rayed\@$mydomain";<br />... $final_spam_destiny = D_PASS;<br />... $banned_filename_re ... # change this to what ever you like<br />... @av_scanners ... # uncomment clamav section<br />... #$QUARANTINEDIR = '/var/virusmails';  # comment QUARANTINEDIR <br /></code></p>
<p>Enabling clamavd and amavisd to start automatically:<br /><code><br /># vi /etc/rc.conf<br />... # Add the following lines<br />... amavisd_enable="YES"<br />... clamav_clamd_enable="YES"<br /># /usr/local/etc/rc.d/clamav-clamd.sh start<br /># /usr/local/etc/rc.d/amavisd.sh start<br /></code></p>
<p>After testing ClamAV, and amavisd, configure postfix to use amavisd:<br /><code><br /># vi /usr/local/etc/postfix/master.conf<br />-------------------------------------<br />smtp-amavis unix -      -       n     -       2  smtp<br />    -o smtp_data_done_timeout=1200<br />    -o smtp_send_xforward_command=yes</p>
<p>127.0.0.1:10025 inet n  -       n     -       -  smtpd<br />    -o content_filter=<br />    -o local_recipient_maps=<br />    -o relay_recipient_maps=<br />    -o smtpd_restriction_classes=<br />    -o smtpd_client_restrictions=<br />    -o smtpd_helo_restrictions=<br />    -o smtpd_sender_restrictions=<br />    -o smtpd_recipient_restrictions=permit_mynetworks,reject<br />    -o mynetworks=127.0.0.0/8<br />    -o strict_rfc821_envelopes=yes<br />    -o smtpd_error_sleep_time=0<br />    -o smtpd_soft_error_limit=1001<br />    -o smtpd_hard_error_limit=1000<br />-------------------------------------<br /># vi /usr/local/etc/postfix/main.cf<br />... content_filter=smtp-amavis:[127.0.0.1]:10024<br /># postfix reload<br /></code></p>
<div style="clear:both; padding-bottom: 0.25em;"></div>
