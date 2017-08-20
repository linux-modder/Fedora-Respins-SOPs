#!/bin/bash
#License:GPLv3
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
mkdir $2 &&
cd /srv/Livecds/$2/
rm -rf /var/lmc &&
echo "starting 64bit build"
livemedia-creator --ks /usr/share/spin-kickstarts/flat-cinn.ks --no-virt --resultdir /var/lmc --project Fedora-CINN-Live --make-iso --volid F$1-CINN-x86_64 --iso-only --iso-name F$1-CINN-x86_64-$2.iso --releasever $1 --title F$1-CINN-x86_64 --macboot &&
echo "CINN DONE"
cp /var/lmc/*.iso /srv/Livecds/$2/ &&
sleep 120 &&
ls /srv/Livecds/$2/ &&
rm -rf /var/lmc &&
livemedia-creator --ks /usr/share/spin-kickstarts/flat-kde.ks --no-virt --resultdir /var/lmc --project Fedora-KDE-Live --make-iso --volid F$1-x86_64-KDE --iso-only --iso-name F$1-KDE-x86_64-$2.iso --releasever $1 --title F$1-KDE-x86_64 --macboot &&
echo "KDE done"
cp /var/lmc/*.iso /srv/Livecds/$2/ &&
sleep 120 &&	
rm -rf /var/lmc &&
livemedia-creator --ks /usr/share/spin-kickstarts/flat-lxde.ks --no-virt --resultdir /var/lmc --project Fedora-LXDE-Live --make-iso --volid F$1-LXDE-x86_64 --iso-only --iso-name F$1-LXDE-x86_64-$2.iso --releasever $1 --title F$1-LXDE-x86_64 --macboot &&
cp /var/lmc/*.iso /srv/Livecds/$2/ &&
sleep 120
rm -rf /var/lmc &&
echo "LXDE Done"
livemedia-creator --ks /usr/share/spin-kickstarts/flat-mate.ks --no-virt --resultdir /var/lmc --project Fedora-MATE-Live --make-iso --volid F$1-MATE-x86_64 --iso-only --iso-name F$1-MATE-x86_64-$2.iso --releasever $1 --title F$1-MATE-x86_64 --macboot &&
cp /var/lmc/*.iso /srv/Livecds/$2/ &&
sleep 120
rm -rf /var/lmc &&
livemedia-creator --ks /usr/share/spin-kickstarts/flat-soas.ks --no-virt --resultdir /var/lmc --project Fedora-SOAS-Live --make-iso --volid F$1-SOAS-x86_64 --iso-only --iso-name F$1-SOAS-x86_64-$2.iso --releasever $1 --title F$1-SOAS-x86_64 --macboot &&
cp /var/lmc/*.iso /srv/Livecds/$2/ &&
sleep 120
rm -rf /var/lmc &&
livemedia-creator --ks /usr/share/spin-kickstarts/flat-work.ks --no-virt --resultdir /var/lmc --project Fedora-WORK-Live --make-iso --volid F$1-WORK-x86_64 --iso-only --iso-name F$1-WORK-x86_64-$2.iso --releasever $1 --title F$1-WORK-x86_64 --macboot &&
cp /var/lmc/*.iso /srv/Livecds/$2/ &&
sleep 120
rm -rf /var/lmc &&
livemedia-creator --ks /usr/share/spin-kickstarts/flat-xfce.ks --no-virt --resultdir /var/lmc --project Fedora-XFCE-Live --make-iso --volid F$1-XFCE-x86_64 --iso-only --iso-name F$1-XFCE-x86_64-$2.iso --releasever $1 --title F$1-XFCE-x86_64 --macboot &&
cp /var/lmc/*.iso /srv/Livecds/$2/
sleep 120 
rm -rf /var/lmc
#livemedia-creator --ks /usr/share/spin-kickstarts/flat-security.ks --no-virt --resultdir /var/lmc --project Fedora-SECURITY-Live --make-iso --volid F$1-SECURITY-x86_64 --iso-only --iso-name F$1-SECURITY-x86_64-$2.iso --releasever $1 --title F$1-SECURITY-x86_64 --macboot &&
#cp /var/lmc/*.iso /srv/Livecds/$2/
#sleep 120
#rm -rf /var/lmc
#echo "starting torrent builds"
cd /srv/Livecds/$2/
sha512sum *.iso >CHECKSUM512-$2 

## Onward to Torrent Generation.

cd /srv/Livecds/$2/
repodir=/srv/Livecds/$2/
hash=$(grep $spin $repodir/CHECKSUM512-$2)
for spin in CINN KDE LXDE MATE WORK SECURITY SOAS XFCE; do 
    transmission-create -c "ISO SHA512SUM: ${hash} " -s 2048 -p -t http://respins.fedorainfracloud.org:6969/announce -o $repodir/F$1-${spin}-x86_64-$2.torrent $repodir/F$1-${spin}-x86_64-$2.iso
    chmod +r $repodir/*.torrent
 
    echo "update opentracker whitelist for ${spin}"
    transmission-show $repodir/F$1-${spin}-x86_64-$2.torrent | awk '/Hash/{print $2 " - "}' >> $repodir/buildfile
    echo F$1-${spin}-x86_64-$2.iso >> $repodir/buildfile
done
cat $repodir/buildfile | paste -d "" - - > /var/opentracker/whitelist
cp $repodir/buildfile whitelist-$2
