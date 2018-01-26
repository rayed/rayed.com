#!/bin/sh

hugo

rsync -azv public/* rayed.com:/home/rayed/rayed.com/public_html/blog

