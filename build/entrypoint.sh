#!/bin/sh

#
# Define source and destination base directories
#
baseSource="/docker"
baseDestination="/vm-etc"

#
# Add custom certificates to Docker Engine folder
#
certsSource="$baseSource/certificates"
certsDestination="$baseDestination/docker/certs.d"

if ! [ -d $certsDestination ]
then
	mkdir -p $certsDestination
fi

cp -r $certsSource/* $certsDestination/

#
# Add custom etc files to Docker Engine etc folder
# 
etcSource="$baseSource/etc"
etcSourceSize=$((${#etcSource}+1))
etcDestination="$baseDestination"

for file in `find $etcSource -type f`
do
	fileSource="$file"	
	fileDestination="$etcDestination/${file:$etcSourceSize}"

	if ! [ -f $fileDestination ]
	then
		touch $fileDestination
	fi

	cat $fileSource >> $fileDestination
done

#
# Keep the script alive to prevent the container exit
#
sh