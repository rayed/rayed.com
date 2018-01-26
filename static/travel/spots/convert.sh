#!/bin/sh


for file in *.png
do
		file=`basename -s .png $file`
		sips -s format jpeg $file.png --out $file.jpg
done
