---
title: 'Virtual FTP accounts with Pure-FTPd  and MySQL'
author: Rayed
type: post
date: 2006-08-19T13:17:09+03:00
categories:
  - MySQL
  - SAUDI NET
  - UNIX
wordpress_id: 261

---
<p><a href="http://www.pureftpd.org/">Pure-FTPd</a> is a FTP server with many features that enable you to host virtual accounts, these are the features that I loved and tested:</p>
<ul>
<li>You can put the user information in MySQL database, without having to create a real UNIX account for each user.</li>
<li>It also have the feature of creating the user home directory when the user logging, so all you need to create a new user is to add it to the database.</li>
<li><b>CallUploadScript</b> this feature will make the server run a script whenever a new file is uploaded, I used this feature to scan the file for viruses as soon as the user upload the file. (I use <a href="http://www.clamav.net/">ClamAV</a> as my virus scanner)</li>
</ul>
<p><b>Installation (FreeBSD)</b><br />
<code><br />
# cd /usr/ports/ftp/pure-ftpd/<br />
# make install<br />
# vi /etc/rc.conf<br />
:<br />
pureftpd_enable="YES"<br />
pureftpd_upload_enable="YES"<br />
pureftpd_uploadscript="/path/to/pureftpd_uploadscript.sh"<br />
:<br />
</code></p>
<p><b>Configuration Files</b><br />
<code><br />
# cat pure-ftpd.conf<br />
Daemonize                   yes<br />
MySQLConfigFile               /usr/local/etc/pureftpd-mysql.conf<br />
CreateHomeDir               yes<br />
CallUploadScript yes<br />
</code><br />
For MySQL setting we need aother file:<br />
<code><br />
# cat pureftpd-mysql.conf<br />
MYSQLSocket     /tmp/mysql.sock<br />
MYSQLUser       my_user<br />
MYSQLPassword   my_password<br />
MYSQLDatabase   my_database<br />
MYSQLCrypt      md5<br />
MYSQLGetPW      SELECT password FROM my_table WHERE username="\L"<br />
MYSQLDefaultUID 1001<br />
MYSQLDefaultGID 1001<br />
MYSQLGetDir     SELECT CONCAT('/path/to/pureftpd/',username) FROM my_table  WHERE username="\L"<br />
MySQLGetQTAFS   SELECT quota_files FROM my_table WHERE username="\L"<br />
MySQLGetQTASZ   SELECT quota_size FROM my_table WHERE username="\L"<br />
</code></p>
