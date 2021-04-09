#!/bin/bash

files="./files.out"

username="admin"
password="admin123"
nexurl="http://10.25.63.108:8081/repository/mydata"

find . -name '*.*' -type f | cut -c3- | grep "/" > $files

while read i; do
	echo "upload $i to $nexusurl"
	curl -v -u $username:$password --upload-file $i "$nexusurl$i"
done <$file