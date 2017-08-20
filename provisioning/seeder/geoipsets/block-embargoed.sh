$!/bin/bash

#####################################################
# block_embargoed.sh
# Author: Dan Mossor, danofsatx
#
# Script created to bring the Fedora Live Respins
# team into United States Export Law Compliance.
# The script makes the following assumtions:
#
# the zone files from http://www.ipdeny.com/ipblocks/
# are downloaded to a directory:
# all-zones.tar.gz is unpacked into ./ipv4/
# ipv6-all-zones.tar.gz is unpacked into ./ipv6/
# any aggregate zone files are in ./aggregated/
#
# Note: North Korea does not have an IPv6 allocation.
#####################################################


ipset create embargoed_nations list:set
for i in cu ir kp sd sy; do ipset create $i-list hash:net; done
for i in cu ir kp sd sy; do for ip in `cat aggregated/$i-aggregated.zone`; do ipset add $i-list $ip; done; done
for i in cu ir kp sd sy; do ipset add embargoed_nations $i-list; done
for i in cu ir kp sd sy; do ls -l ipv6/$i.zone; done
for i in cu ir sd sy; do ipset create $i-v6-list hash:net family inet6; done
for i in cu ir sd sy; do for ip in `cat ipv6/$i.zone`; do ipset add $i-v6-list $ip; done; done
for i in cu ir sd sy; do ipset add blacklist $i-v6-list; done
for i in cu ir sd sy; do ipset add embargoed_nations $i-v6-list; done
ipset list embargoed_nations
firewall-cmd --add-rich-rule='rule source ipset=embargoed_nations drop'
firewall-cmd --runtime-to-permanent
