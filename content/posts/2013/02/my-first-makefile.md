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
The following is a sample Makefile for simple project, here I am building a simple "<a href="http://en.wikipedia.org/wiki/Bloom_filter">Bloom Filter</a>" library, and "main" program to use it.

The library will have the following files:

- hash.h and hash.c
- bloom.h and bloom.c

and we should get "libbloom.a" out of it.

The "main" program will use:

- main.c
- bloom.h
- libbloom.a

and we should get "main" executable. So our make file should look like this: 

    $ cat Makefile
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


**Makefile use TAB not spaces for indentation.**

To execute it just type "make" in the same directory where "Makefile" reside.

Macros Explained: 
http://www.cs.duke.edu/~ola/courses/programming/Makefiles/node7.html