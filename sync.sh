#!/bin/sh


hugo

rsync -azv public rayed.com:rayed.com

