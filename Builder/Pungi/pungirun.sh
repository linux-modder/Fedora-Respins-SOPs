#!/bin/bash
#License: GPL2 or 3
#Author Ben Williams jbwillia@fedoraproject.org
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
 
mkdir $2 &&
 
echo "staring pungi runs"
echo "start x86_64 Gather Stage"
 
pungi -G  -c /usr/share/spin-kickstarts/all-flat2.ks --name Fedora --ver $1 --force &&
 
pungi -C  -c /usr/share/spin-kickstarts/all-flat2.ks --name Fedora --ver $1 --force &&
 
pungi -I -c /usr/share/spin-kickstarts/all-flat2.ks --name Fedora --ver $1 --sourceisos --force &&
 
cd 25/source/iso/ &&
 
cp * /srv/Livecds/$2/ &&
 
cd /srv/Livecds/$2/ &&
 
sha256sum -c Fedora-$1-source-CHECKSUM &&
 
mv Fedora-DVD-source-$1.iso  F$1-source-$2.iso &&
 
rm -rf Fedora-$1-source-CHECKSUM &&
 
rm -rf Fedora-DVD-source-$1.iso &&
 
#echo "remove pungi subDs"
#rm -rf 22/ &&
 
rm -rf fedora/ &&
 
rm -rf logs/ &&
 
rm -rf source/ &&
 
rm -rf updates/ &&
 
rm -rf updates-source/ &&
 
rm -rf work/ &&
%end
