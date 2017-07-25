## Scripts Directory README.md
=-=-=-=-=-=-=-=--=-=-=-=-=-=-=


This directory is solely for hosting the scripts in one place. This is for educational purposes, i.e. reading in a directory separate form others and not in the path of the rest of the executable bits, in such that changes will not natively effect any production runs/configurations.

## Scripts explained
====================

+ buildmedia.sh 
This is the basic buildscript WITHOUT the generation of torrents, this is often called the spin test script.
This script in a nutshell does the following:

* Sets SELinux to Permissive  (setenforce 0)
* Creates a directory for the ${BUILD_DATE} inside the ${root_dir} of ``/srv/Livecds/``
* Runs (In Series logic, the respective flattened fedora-kickstarts for the respins Desktops {CINN,KDE,LXDE,MATE,SOAS,WORK,XFCE,LXQT(LXQT debut on F26}
* Moves each respective Finished and built iso from it's build dir of ``/var/lmc`` to ``/srv/Livecds/$2`` ($2 denotes the $builddate)
* Creates a iso CHECKSUM512 file with the filename syntax of CHECKSUM512-$2 ( again $2 denotes $builddate)
* Resets SELinux back to enforcing (setenforce 1)


+ buildmedia-all.sh 
This script is nearly identical to buildmedia.sh however, it additionally does the following:

* 
