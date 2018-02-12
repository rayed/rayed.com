#!/bin/sh


HUGO_ENV="production" hugo

rsync -azv public rayed.com:rayed.com

