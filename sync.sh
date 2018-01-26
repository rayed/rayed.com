#!/bin/sh

hugo

rsync -azv --delete public/* rayed.com:/home/rayed/rayed.com/public_html/blog

