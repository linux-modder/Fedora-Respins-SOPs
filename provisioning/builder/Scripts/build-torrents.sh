#!/bin/bash
 
repodir=/srv/fedora-repo/F25-Respins
 
#for spin in CINN KDE LXDE MATE WORK SOAS XFCE; do
for spin in CINN KDE LXDE MATE WORK SECURITY SOAS XFCE; do 
   hash=$(grep $spin $repodir/CHECKSUM512-$2)
    transmission-create -c "ISO SHA512SUM: ${hash} " -s 2048 -p -t http://respins.fedorainfracloud.org:6969/announce -o $repodir/F$1-${spin}-x86_64-$2.torrent $repodir/F$1-${spin}-x86_64-$2.iso
    chmod +r $repodir/*.torrent
 
    echo "update opentracker whitelist for ${spin}"
    transmission-show $repodir/F$1-${spin}-x86_64-$2.torrent | awk '/Hash/{print $2 " - "}' >> $repodir/buildfile
    echo F$1-${spin}-x86_64-$2.iso >> $repodir/buildfile
done
cat $repodir/buildfile | paste -d "" - - > /var/opentracker/whitelist
/bin/rm $repodir/buildfile 

