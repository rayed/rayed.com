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
I can't believe how many times I forget this trick! so I am writing it down so I won't forget it!

Normally when you use printf function with "%s" formatting to print a string (char *) you rely on C convention of terminating a string with a NULL character (i.e. value 0).

So if you want to print small part of longer string, you copy the part you need to a new buffer and terminate it will NULL.

A better way is to use printf format for string i.e. "%s" with a precision which indicates how many characters will be used:

    char *s = "Hi my name is Rayed, nice to meet you!";
    printf("Hello, %.5s!\n", s+14);

If the length is not known in advance you can provide it as an argument to printf too:

    char *s = "Hi my name is Rayed, nice to meet you!";
    printf("Hello, %.*s!\n", 5, s+14);

Notice the "%.*s" and the extra "5" argument.

