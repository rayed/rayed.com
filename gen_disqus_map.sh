#!/bin/sh


grep -r "wordpress_id" content/posts | \
sed 's/^content//' | \
sed 's#.md:wordpress_id: #/,#' | \
awk -F, ' { printf("https://rayed.com/wordpress/?p=%s,https://rayed.com%s\n", $2, $1) }' > \
disqus_map.out.csv