#!/bin/sh

HUGO_ENV="production" hugo
rsync -azv  public rr.sa:rayed.com