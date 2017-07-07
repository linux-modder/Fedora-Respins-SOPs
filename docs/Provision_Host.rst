# Provisioning a new host/node


# Pre-Requisites

* Host OS MUST be Fedora

* Livecd-creator/Livemedia-creator build directory (default is /var/lmc) must be at least 30gb (builder nodes are using a minimum 50gb)

## Packages

* fedora-kickstarts  // packaged kickstarts
* pungi  // needed for building the source.iso
* livecd-tools OR lorax-lmc-novirt // lorax-lmc-novirt is livemedia-creator
* pykickstart // for modifying kickstarts, ksvalidator is part of this package
* mock // while not a must have, it does provide a sane clean instance to build in


# Host Security

## Minimal networking security measures

* firewalld active, with minimal static port exposure, USE services (at least http and/or https,transmission-daemon,ssh)
* ssh as root disabled, OR forced to use keys ONLY, PASSWORDS strictly prohibited
* NO PRIVATE KEYS, ssh or otherwise (except host_keys) are allowed on any remote hosts.
* groups: respins,transmission,hosted-content created
* chgrp -R hosted-content /srv/Livecds  // Test build default directory
* chmod 775 /srv/fedora-repo // Seeding and web server $doc_root for testing
* chmod -R 755 /srv/fedora-repo
* users: local user must part of wheel and/or respins // if the latter, respins must be in wheel,or otherwise able to run sudo in/for operations inside /srv/Livecds and /srv/fedora-repo

## Security -- Firewall

### This will administratively block ALL traffic form any of the 5 countries within the Cat 5 E chart, provided by the US Dept of Commerce, Embargoed Nations (As of 20170704, these countries were Cuba, North korea, Sudan, Syria,Iran, however these may change, these zonefiles are updated on average once a quarter. 

git clone git@github.com/linux-modder/firewalld-embargoed_nations 
cd firewalld-embargoed_nations
sudo bash ./block-embargoed_nations.sh   
