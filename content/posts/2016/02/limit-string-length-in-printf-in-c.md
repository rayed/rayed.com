---
title: Limit String Length in Printf in C
author: Rayed
type: post
date: 2016-02-17T23:22:14+03:00
categories:
  - Uncategorized
tags:
  - c
  - printf
  - string
wordpress_id: 1885

---
<p>I can&#8217;t believe how many times I forget this trick! so I am writing it down so I won&#8217;t forget it!</p>
<p>Normally when you use printf function with &#8220;%s&#8221; formatting to print a string (char *) you rely on C convention of terminating a string with a NULL character (i.e. value 0).</p>
<p>So if you want to print small part of longer string, you copy the part you need to a new buffer and terminate it will NULL.</p>
<p>A better way is to use printf format for string i.e. &#8220;%s&#8221; with a precision which indicates how many characters will be used:</p>
<p><code></p>
<pre>char *s = "Hi my name is Rayed, nice to meet you!";
printf("Hello, %.5s!\n", s+14);</pre>
<p></code></p>
<p>If the length is not known in advance you can provide it as an argument to printf too:</p>
<p><code></p>
<pre>char *s = "Hi my name is Rayed, nice to meet you!";
printf("Hello, %.*s!\n", 5, s+14);</pre>
<p></code></p>
<p>Notice the &#8220;%.*s&#8221; and the extra &#8220;5&#8221; argument.</p>
