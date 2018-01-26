---
title: Loop Unwinding Experiment
author: Rayed
type: post
date: 2011-06-04T17:43:12+03:00
categories:
  - Uncategorized
tags:
  - c
  - optimization
  - programming
wordpress_id: 842

---
<p>Few months ago I read an interesting post by Mike Haertel the original author of GNU grep titled &#8220;<a href="http://lists.freebsd.org/pipermail/freebsd-current/2010-August/019310.html">why GNU grep is fast</a>&#8220;, one of the reason given is loop unrolling.<br />
Few weeks ago I came a cross the same post which made me more interested on <a href="http://en.wikipedia.org/wiki/Loop_unwinding">Loop Unrolling</a>, so I decided to experiment with it, I implemented simple function to search for an item inside a list of items, and return as soon as it finds it, soo here is my result:</p>
<table border="1" cellpadding="4">
<tbody>
<tr>
<td></td>
<td>First</td>
<td>Middle</td>
<td>Not in Array</td>
</tr>
<tr>
<td>Normal Loop</td>
<td align="right">0.387</td>
<td align="right">1.495</td>
<td align="right">2.605</td>
</tr>
<tr>
<td>Unrolled Loop</td>
<td align="right">0.397</td>
<td align="right">1.07</td>
<td align="right">1.701</td>
</tr>
<tr>
<td>Improvement</td>
<td align="right">-2.52</td>
<td align="right">39.72</td>
<td align="right">53.15</td>
</tr>
<tr height="15">
<td height="15"></td>
<td></td>
<td></td>
<td></td>
</tr>
<tr>
<td>O2 Normal Loop</td>
<td align="right">0.045</td>
<td align="right">0.279</td>
<td align="right">0.373</td>
</tr>
<tr>
<td>O2 Unrolled Loop</td>
<td align="right">0.045</td>
<td align="right">0.217</td>
<td align="right">0.285</td>
</tr>
<tr>
<td>Improvement</td>
<td align="right">0.00</td>
<td align="right">28.57</td>
<td align="right">30.88</td>
</tr>
</tbody>
</table>
<p>The result is taken using the &#8220;time&#8221; command, &#8220;O2&#8221; means compiling the program with optimization level 2.</p>
<pre>
#include &lt;stdio.h&gt;

inline int item_match_fast(int item, int * items, int items_size)
{
    int i;
    int repeat, left;

    repeat = items_size / 8;
    left = items_size % 8;

    i = 0;
    while (repeat-- > 0) {
        if (item==items[i]) { return 1; }
        if (item==items[i+1]) { return 1; }
        if (item==items[i+2]) { return 1; }
        if (item==items[i+3]) { return 1; }
        if (item==items[i+4]) { return 1; }
        if (item==items[i+5]) { return 1; }
        if (item==items[i+6]) { return 1; }
        if (item==items[i+7]) { return 1; }
        i += 8;
    }

    switch(left) {
        case 7: if (item==items[i+7]) { return 1; }
        case 6: if (item==items[i+6]) { return 1; }
        case 5: if (item==items[i+5]) { return 1; }
        case 4: if (item==items[i+4]) { return 1; }
        case 3: if (item==items[i+3]) { return 1; }
        case 2: if (item==items[i+2]) { return 1; }
        case 1: if (item==items[i+1]) { return 1; }
        case 0: ; /* don nothing */
    }

    return 0;
}

inline int item_match(int item, int * items, int items_size)
{
    int i;

    /* check items array */
    for (i=0; i&lt;items_size ; i++) {
        if(item==items[i]) {
            return 1;
        }
    }
    return 0;
}

#define REPEAT 10000000
#define ITEM 7070

int main(int argc, char ** argv)
{
    int i;
    int items[] = { 1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010,
                    1011, 1012, 1013, 1014, 1015, 1016, 1017, 1018, 1019, 1020 };
    int items_size = 20;

    if (argc==2) {
        printf("Loop unrolled\n");
        for (i=0;i&lt;REPEAT; i++) {
            item_match_fast(ITEM, items, items_size);
        }

    } else {
        printf("Normal Loop\n");
        for (i=0;i&lt;REPEAT; i++) {
            item_match(ITEM, items, items_size);
        }
    }

    return 0;
}
</pre>
