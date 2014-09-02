#
# Cookbook Name:: ipmi
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "OpenIPMI" do
        action :install
end

template "/etc/modprobe.d/ipmi.conf" do
    mode "0644"
    owner "root"
    source "ipmi.conf.erb"
end
