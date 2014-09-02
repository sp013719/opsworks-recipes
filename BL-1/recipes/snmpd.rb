#
# Cookbook Name:: snmpd
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "net-snmp" do
        action :install
end

package "net-snmp-utils" do
        action :install
end

package "net-snmp-perl" do
        action :install
end

template "/etc/snmp/snmpd.conf" do
    mode "0644"
    owner "root"
    source "snmpd.conf.erb"
end
