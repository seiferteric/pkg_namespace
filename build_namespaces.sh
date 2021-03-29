#!/bin/bash

#This creates a bin directory that you can add to your path to namespace your binaries 
# by the package name. Such as "imagemagick-6.q16/convert" instead of just "convert".
#This would help if you just installed a package and you didn't know what binaries it
# has installed.


rm -rf bin
mkdir -p bin

for lst in /var/lib/dpkg/info/*.list
do
	bname=$(basename $lst)
	pkg=${bname%.list}
	bins=$(grep -e "^/bin/" -e "^/usr/bin/" -e "^/usr/sbin/" -e "^/usr/local/bin/" -e "^/user/local/sbin/" $lst)
	if [ $? -eq 0 ]
	then
		# mkdir -p bin/$pkg
		for bin in $bins
		do
			bname=$(basename $bin)
			ln -s $bin bin/$pkg#$bname
		done
	fi
done
#Also need to handle symlinks in /etc/alternatives
IFS=$'\n'
for alt in $(update-alternatives --get-selections)
do
	unset IFS
	
	bin=${alt% [auto|manual]*$}
	bin=${alt%[[:space:]]*[auto|manual][[:space:]]*}
	lnk=${alt#[[:graph:]]*[[:space:]]*[auto|manual][[:space:]]*}
	bins=$(echo -n $lnk | grep -e "^/bin/" -e "^/usr/bin/" -e "^/usr/sbin/" -e "^/usr/local/bin/" -e "^/user/local/sbin/")
	if [ $? -eq 0 ]
	then
		lst=$(grep -l $bins /var/lib/dpkg/info/*.list | head -n 1)
		bname=$(basename $lst)
		pkg=${bname%.list}
		# mkdir -p bin/$pkg

		ln -s $lnk bin/$pkg#$bin
	fi
	IFS=$'\n'
done
unset IFS