#version=DEVEL
# System authorization information
auth --enableshadow --passalgo=sha512
# Use CDROM installation media
cdrom
# Use graphical install
graphical
# Run the Setup Agent on first boot
firstboot --enable
ignoredisk --only-use=sda
# Keyboard layouts
keyboard --vckeymap=us --xlayouts='us'
# System language
lang en_US.UTF-8

# Network information
network  --bootproto=dhcp --device=enp1s0 --mtu=1280 --nameserver=::1,8.8.8.8,2001:4860:4860::8888,2620::ccc:2,208.67.222.222,127.0.0.1 --ipv6=auto --no-activate
network  --hostname=localhost.localdomain
# Root password
rootpw --iscrypted  7bbf85dec30e9d1d0b75cfa244bed81757efbae2904948dbbacf8759751e19519ae8ca5e2a8c132588a3fc8a8aa788fad9ba850a3a38f7fa89f20423116c94be ## sha512sum value of: td512server
# System services
services --enabled="chronyd"
# System timezone
timezone Etc/GMT --ntpservers=0.pool.ntp.org,0.pool.ntp.org,0.pool.ntp.org,0.pool.ntp.org,0.north-america.pool.ntp.org,0.north-america.pool.ntp.org,0.north-america.pool.ntp.org,0.north-america.pool.ntp.org,0.south-america.pool.ntp.org,0.south-america.pool.ntp.org,0.south-america.pool.ntp.org,0.south-america.pool.ntp.org,0.africa.pool.ntp.org,0.africa.pool.ntp.org,0.africa.pool.ntp.org,0.africa.pool.ntp.org,0.europe.pool.ntp.org,0.europe.pool.ntp.org,0.europe.pool.ntp.org,0.europe.pool.ntp.org
user --groups=wheel --name=td512 --password=7bbf85dec30e9d1d0b75cfa244bed81757efbae2904948dbbacf8759751e19519ae8ca5e2a8c132588a3fc8a8aa788fad9ba850a3a38f7fa89f20423116c94be --iscrypted --gecos="Levi"
# System bootloader configuration
bootloader --location=mbr --boot-drive=sda
# Partition clearing information
clearpart --none --initlabel
# Disk partitioning information  ## assumes a 500gb hard drive with pre-configured partitions  (hence the --noformat --useexisting), also assumes efi in use  if not remove /boot/efi partition, OR leave it made and umounted for future uses
part pv.268 --fstype="lvmpv" --noformat --encrypted
part /boot --fstype="xfs"
part /boot/efi --fstype="efi" --noformat --fsoptions="umask=0077,shortname=winnt"
volgroup td512-server --noformat --useexisting
logvol /  --fstype="xfs" --useexisting --name=root --vgname=td512
logvol /var/log  --fstype="xfs" --useexisting --name=var_log --vgname=td512
logvol /var  --fstype="xfs" --useexisting --name=var --vgname=td512
logvol /usr/local  --fstype="xfs" --useexisting --name=usr_local --vgname=td512
logvol /usr  --fstype="xfs" --useexisting --name=usr --vgname=td512
logvol /srv  --fstype="xfs" --useexisting --name=srv --vgname=td512
logvol /home  --fstype="xfs" --useexisting --name=home --vgname=td512
logvol swap  --fstype="swap" --useexisting --name=swap --vgname=td512
#logvol /scripts  --fstype="xfs" --useexisting --name=scripts --vgname=td512 ## Use this for system-wide scripts and have respective ~/scripts for users that need them
logvol /var/lib/images  --fstype="xfs" --useexisting --name=var_lib_images --vgname=td512

%packages
@^server-product-environment
@ansible-node
@arm-tools
@container-management
@domain-client
@editors
@freeipa-server
@guest-agents
@hardware-support
@headless-management
@mail-server
@networkmanager-submodules
@server-hardware-support
@smb-server
@sql-server
@virtualization-headless
@web-server
chrony
cadaver
fontconfig
fontpackages-filesystem
gd
hddtemp
jbigkit-libs
libX11
libX11-common
libXau
libXpm
libicu
libjpeg-turbo
libmcrypt
libtiff
libuv
libwebp
libxcb
libyaml
mariadb
mariadb-common
mariadb-config
mariadb-errmsg
mariadb-libs
mariadb-server
mariadb-server-utils
mod_passenger
monit
neon
pakchois
passenger
patch
perl-Authen-PAM
perl-Compress-Raw-Bzip2
perl-Compress-Raw-Zlib
perl-DBD-MySQL
perl-DBI
perl-Digest
perl-Digest-HMAC
perl-Digest-MD5
perl-Digest-SHA
perl-Encode-Locale
perl-File-Listing
perl-HTML-Parser
perl-HTML-Tagset
perl-HTTP-Cookies
perl-HTTP-Date
perl-HTTP-Message
perl-HTTP-Negotiate
perl-IO-Compress
perl-IO-HTML
perl-LWP-MediaTypes
perl-LWP-Protocol-https
perl-Math-BigInt
perl-Math-Complex
perl-NTLM
perl-Net-HTTP
perl-Storable
perl-TimeDate
perl-WWW-RobotRules
perl-libwww-perl
php
php-cli
php-common
php-gd
php-json
php-mbstring
php-mcrypt
php-mysqlnd
php-pdo
php-xml
pmount
python-talloc
ruby
ruby-augeas
ruby-irb
ruby-libs
rubygem-bigdecimal
rubygem-bundler
rubygem-daemon_controller
rubygem-did_you_mean
rubygem-io-console
rubygem-json
rubygem-mysql2
rubygem-psych
rubygem-rack
rubygem-rake
rubygem-rdoc
rubygem-ruby-dbus
rubygems
rubypick
samba
samba-common-libs
samba-common-tools
samba-libs
v8
wol

%end

%addon com_redhat_kdump --disable --reserve-mb='128'

%end


%post --chroot 

## Install dependency packages  for Amahi, as well as Amahi so that it will be ready on the installed system as well as installer
dnf install -y \
cadaver \
fontconfig \
fontpackages-filesystem \
gd \
hddtemp \
jbigkit-libs \
libX11 \
libX11-common \
libXau \
libXpm \
libicu \
libjpeg-turbo \
libmcrypt \
libtiff \
libuv \
libwebp \
libxcb \
libyaml \
mariadb \
mariadb-common \
mariadb-config \
mariadb-errmsg \
mariadb-libs \
mariadb-server \
mariadb-server-utils \
mod_passenger \
monit \
neon \
pakchois \
passenger \
patch \
perl-Authen-PAM \
perl-Compress-Raw-Bzip2 \
perl-Compress-Raw-Zlib \
perl-DBD-MySQL \
perl-DBI \ 
perl-Digest \
perl-Digest-HMAC \ 
perl-Digest-MD5 \ 
perl-Digest-SHA \
perl-Encode-Locale \
perl-File-Listing \
perl-HTML-Parser \
perl-HTML-Tagset \
perl-HTTP-Cookies \
perl-HTTP-Date \
perl-HTTP-Message \
perl-HTTP-Negotiate \
perl-IO-Compress \
perl-IO-HTML \
perl-LWP-MediaTypes \
perl-LWP-Protocol-https \
perl-Math-BigInt \
perl-Math-Complex \
perl-NTLM \
perl-Net-HTTP \
perl-Storable \
perl-TimeDate \
perl-WWW-RobotRules \
perl-libwww-perl \
php \
php-cli \
php-common \
php-gd \
php-json \
php-mbstring \
php-mcrypt \
php-mysqlnd \
php-pdo \
php-xml \
pmount \
python-talloc \
ruby \
ruby-augeas \
ruby-irb \
ruby-libs \
rubygem-bigdecimal \
rubygem-bundler \
rubygem-daemon_controller \
rubygem-did_you_mean \
rubygem-io-console \
rubygem-json \
rubygem-mysql2 \
rubygem-psych \
rubygem-rack \
rubygem-rake \
rubygem-rdoc \
rubygem-ruby-dbus \
rubygems \
rubypick \
samba \
samba-common-libs \
samba-common-tools \
samba-libs \
v8 \
wol &&

dnf install -y Amahi 

%end 
%anaconda
pwpolicy root --minlen=0 --minquality=1 --notstrict --nochanges --emptyok
pwpolicy user --minlen=0 --minquality=1 --notstrict --nochanges --emptyok
pwpolicy luks --minlen=0 --minquality=1 --notstrict --nochanges --emptyok
%end
