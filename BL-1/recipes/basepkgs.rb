#
# Cookbook Name:: basepkgs
# Recipe:: default
#
# Copyright 2014, Trend Micro Inc
#
# All rights reserved - Do Not Redistribute
#

%w{audit augeas-libs autofs bash bind-utils bzip2 bzip2-libs compat-libcap1 crontabs csh device-mapper-multipath dhclient dmidecode diffutils e2fsprogs e4fsprogs emacs grub iscsi-initiator-utils kernel krb5-libs krb5-workstation libselinux-ruby logrotate lsof mailx man module-init-tools nc net-snmp net-snmp-libs net-snmp-utils net-snmp-perl nfs-utils nfs-utils-lib nmap ntp OpenIPMI openssh openssh-clients openssh-server pam_passwdqc parted portmap postfix psacct rsync rsyslog ruby rubygems ruby-libs screen sudo strace sysstat tcpdump telnet traceroute unzip vim-enhanced virt-what wget which yum zsh}.each do |p|
	package p do
		action :install
	end
end
