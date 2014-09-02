#
# Cookbook Name:: patch
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

patch=node['BL-1']['patch']['patch_list']


patch.each do |p|
        yum_package p do
                action :upgrade
        end
end

