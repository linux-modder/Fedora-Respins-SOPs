#!/bin/bash
#License:GPL2 or GPL3

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
setenforce 0 &&
mkdir $2 &&

cd /srv/Livecds/$2/ &&
rm -rf /var/lmc &&
setenforce 0 &&
echo "starting 64bit build"

livemedia-creator --ks /usr/share/spin-kickstarts/flat-cinn.ks --no-virt --resultdir /var/lmc --project Fedora-CINN-Live --make-iso --volid F$1-CINN-x86_64 --iso-only --iso-name F$1-CINN-x86_64-$2.iso --releasever $1 --title F$1-CINN-x86_64 --macboot &&

echo "CINN DONE" &&

cp /var/lmc/*.iso /srv/Livecds/$2/ &&

sleep 120 &&

ls /srv/Livecds/$2/ &&

rm -rf /var/lmc &&


livemedia-creator --ks /usr/share/spin-kickstarts/flat-kde.ks --no-virt --resultdir /var/lmc --project Fedora-KDE-Live --make-iso --volid F$1-x86_64-KDE --iso-only --iso-name F$1-KDE-x86_64-$2.iso --releasever $1 --title F$1-KDE-x86_64 --macboot &&

echo "KDE done"

cp /var/lmc/*.iso /srv/Livecds/$2/ &&
sleep 120 &&
ls /srv/Livecds/$2/ &&

sleep 120 &&	
rm -rf /var/lmc &&

livemedia-creator --ks /usr/share/spin-kickstarts/flat-lxde.ks --no-virt --resultdir /var/lmc --project Fedora-LXDE-Live --make-iso --volid F$1-LXDE-x86_64 --iso-only --iso-name F$1-LXDE-x86_64-$2.iso --releasever $1 --title F$1-LXDE-x86_64 --macboot &&

cp /var/lmc/*.iso /srv/Livecds/$2/ &&
sleep 120 &&
ls /srv/Livecds/$2/ &&

rm -rf /var/lmc &&
#echo "LXDE Done"

livemedia-creator --ks /usr/share/spin-kickstarts/flat-lxqt.ks --no-virt --resultdir /var/lmc --project Fedora-LXQT-Live --make-iso --volid F$1-LXQT-x86_64 --iso-only --iso-name F$1-LXQT-x86_64-$2.iso --releasever $1 --title F$1-LXQT-x86_64 --macboot &&

cp /var/lmc/*.iso /srv/Livecds/$2/ &&
sleep 120 &&
ls /srv/Livecds/$2/ &&

rm -rf /var/lmc &&
#echo "LXQT Done"

livemedia-creator --ks /usr/share/spin-kickstarts/flat-mate.ks --no-virt --resultdir /var/lmc --project Fedora-MATE-Live --make-iso --volid F$1-MATE-x86_64 --iso-only --iso-name F$1-MATE-x86_64-$2.iso --releasever $1 --title F$1-MATE-x86_64 --macboot &&

cp /var/lmc/*.iso /srv/Livecds/$2/ &&
sleep 120 &&
ls /srv/Livecds/$2/ &&

echo "Mate" &&
rm -rf /var/lmc &&

livemedia-creator --ks /usr/share/spin-kickstarts/flat-soas.ks --no-virt --resultdir /var/lmc --project Fedora-SOAS-Live --make-iso --volid F$1-SOAS-x86_64 --iso-only --iso-name F$1-SOAS-x86_64-$2.iso --releasever $1 --title F$1-SOAS-x86_64 --macboot &&

cp /var/lmc/*.iso /srv/Livecds/$2/ &&
sleep 120 &&
echo "SOAS" &&
ls /srv/Livecds/$2/ &&
rm -rf /var/lmc &&

livemedia-creator --ks /usr/share/spin-kickstarts/flat-work.ks --no-virt --resultdir /var/lmc --project Fedora-WORK-Live --make-iso --volid F$1-WORK-x86_64 --iso-only --iso-name F$1-WORK-x86_64-$2.iso --releasever $1 --title F$1-WORK-x86_64 --macboot &&

cp /var/lmc/*.iso /srv/Livecds/$2/ &&
sleep 120 &&
echo "WORK" &&
ls /srv/Livecds/$2/ &&
rm -rf /var/lmc &&

livemedia-creator --ks /usr/share/spin-kickstarts/flat-xfce.ks --no-virt --resultdir /var/lmc --project Fedora-XFCE-Live --make-iso --volid F$1-XFCE-x86_64 --iso-only --iso-name F$1-XFCE-x86_64-$2.iso --releasever $1 --title F$1-XFCE-x86_64 --macboot &&

cp /var/lmc/*.iso /srv/Livecds/$2/
sleep 120 &&
ls /srv/Livecds/$2/ &&
rm -rf /var/lmc

#livemedia-creator --ks /usr/share/spin-kickstarts/flat-security.ks --no-virt --resultdir /var/lmc --project Fedora-SECURITY-Live --make-iso --volid F$1-SECURITY-x86_64 --iso-only --iso-name F$1-SECURITY-x86_64-$2.iso --releasever $1 --title F$1-SECURITY-x86_64 --macboot &&

#cp /var/lmc/*.iso /srv/Livecds/$2/
#sleep 120
#rm -rf /var/lmc

#livemedia-creator --ks /usr/share/spin-kickstarts/flat-robotics.ks --no-virt --resultdir /var/lmc --project Fedora-Robotics --make-iso --volid F$1-ROBOTICS-x86_64 --iso-only --iso-name F$1-RObotics-x86_64-$2.iso --releasever $1 --title F$1-ROBOTICS-x86_64 --macboot &&

#cp /var/lmc/*.iso /srv/Livecds/$2/
#sleep 120
#rm -rf /var/lmc

cd /srv/Livecds/$2/
sha512sum *.iso >CHECKSUM512-$2 
setenforce 1


