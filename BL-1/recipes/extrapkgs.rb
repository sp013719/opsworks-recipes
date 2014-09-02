#
# Cookbook Name:: extrapkgs
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


#no omnibus-tnaclient
#package "subversion.i686" do
#        action :install
#end


#
# missing rpmwhy, htop package
# %w{patch rpmwhy strace sysstat lftp htop mlocate subversion}.each do |p|
#

%w{patch strace sysstat lftp mlocate subversion}.each do |p|
	package p do
		action :install
	end
end
