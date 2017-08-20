Provisioning a New Builder
==========================

These playbooks are used to provision new builders.

Manual Linode Process to Login and Move to Fedora Kernel
--------------------------------------------------------
Setup a few things on the node to use the Fedora provided kernel and enable SELinux.

### Control the Boot Process
Disable Lassie booting in the Linode console. Login and ensure the node will be able to PVGRUB and set the hostname:

```shell
ssh root@$loc.fspin.org
hostnamectl set-hostname $loc.fspin.org
dnf -y install kernel-core grub2 ansible libselinux-python
shutdown -h now
```

### Change the Kernel in Linode to GRUB 2
Go into the configuration profile and change the kernel to boot to GRUB 2. Connect to the weblish and then boot and interrupt boot. Add the following runtime kernel options:

```
enforcing=0 autorelabel=1
```

This will auto-reboot, ending in an offline node. Enable Lassie booting. Boot the Linode.

### Run ansible Initial Configuration
Run the initial configuration to create users and install base programs.

Create a user with sudo to run the playbook:

```shell
useradd $user
usermod $user -a -G wheel
passwd $user
```
Run the playbook as the user:

```shell


```

