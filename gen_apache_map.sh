#!/bin/sh

OUTPUT="static/wordpress/index.php"

cat > $OUTPUT <<'EOF'
<?php
$map = array(
EOF

grep -r "wordpress_id" content/posts | \
sed 's/^content//' | \
sed 's#.md:wordpress_id: #/,#' | \
awk -F, ' { printf(" \"%s\" => \"%s\", \n", $2, $1) }' >> $OUTPUT

cat >> $OUTPUT <<'EOF'
);

if (isset($_GET["p"]) and isset($map[$_GET["p"]])) {
    header("Location: " . $map[$_GET["p"]] );
} else {
    header("Location: /");
}

EOF
