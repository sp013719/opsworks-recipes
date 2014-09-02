#
# Cookbook Name:: miscprofile
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#note: requires software

template "/etc/bashrc" do
    source "bashrc.erb"
    mode "0775"
    owner "root"
end
