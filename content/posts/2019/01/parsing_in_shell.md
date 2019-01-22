---
title: "Parsing In Shell Script"
date: 2019-01-22T17:34:43+03:00
type: post
---

Here a small snippet to parse name:value pairs is shell script:

<!--more-->

    #!/bin/sh

    values="

    centos: CentOS 7
    ubuntu:    Ubuntu 1804    

    "

    IFS=$'\n'
    for i in $values; do
        IFS=':' read -ra vals <<< "$i"	
        unset IFS
        read  -rd '' name <<< "${vals[0]}"
        read  -rd '' value <<< "${vals[1]}"
        echo "[$name] = [$value]"
    done

Output:

    [centos] = [CentOS 7]
    [ubuntu] = [Ubuntu 1804]

It mainly utilize the "internal field separator" or `IFS`, and the `read` builtin function.

The first step is to split the string using new line, with `IFS=$'\n'`.

Then we split using the colon `:`, and use `read -ra vals` to split the input and put it in an array.

Finally, we use `read -rd ''` again to get trim spaces from each field. 
