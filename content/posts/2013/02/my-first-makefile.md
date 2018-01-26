---
title: My First Makefile
author: Rayed
type: post
date: 2013-02-10T14:15:37+03:00
categories:
  - Uncategorized
tags:
  - c
  - development
  - linux
wordpress_id: 1108

---
<p>The following is a sample Makefile for simple project, here I am building a simple &#8220;<a href="http://en.wikipedia.org/wiki/Bloom_filter">Bloom Filter</a>&#8221; library, and &#8220;main&#8221; program to use it. The library will have the following files:<br />
*   hash.h and hash.c<br />
*   bloom.h and bloom.c and we should get &#8220;libbloom.a&#8221; out of it. The &#8220;main&#8221; program will use:</p>
<ul>
<li>main.c</li>
<li>bloom.h</li>
<li>libbloom.a and we should get &#8220;main&#8221; executable. So our make file should look like this: </li>
</ul>
<pre>$ cat Makefile
CFLAGS=-Wall -O3
LDFLAGS= -L.
LDLIBS=-lbloom

CFLAGS += `pkg-config --cflags libpcre`
LDFLAGS += `pkg-config --libs libpcre`


OBJS=main.o other.o libbloom.a
BLOOM_OBJS=hash.o bloom.o

all: main libbloom.a

main: $(OBJS)
        $(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)

libbloom.a: $(BLOOM_OBJS)
        ar rcs $@ $^


.PHONY: clean
clean:
        -rm main libbloom.a *.o 
</pre>
<p><strong>Makefile use TAB not spaces for indentation.</strong> To execute it just type &#8220;make&#8221; in the same directory where &#8220;Makefile&#8221; reside. Macros Explained: <a href="http://www.cs.duke.edu/~ola/courses/programming/Makefiles/node7.html">http://www.cs.duke.edu/~ola/courses/programming/Makefiles/node7.html</a></p>
