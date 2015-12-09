include_recipe 'kubernetes-rhel::repo-setup'

# pass private network CIDR to etcd
#cluster_cidr => node['kubernetes']['cluster_cidr'],

package ['kubernetes-master', 'kubernetes-client']

template "/etc/kubernetes/apiserver" do
	mode "0600"
	owner "root"
	source "master-apiserver.conf.erb"
	variables({
		:etcd_url => node['etcd']['elb_url'],
		:ba_path => "/root/ba_file",
		:etcd_ba_account => "root",
		:etcd_ba_password => node['etcd']['password']
	})
end

file "/root/ba_file" do
	owner 'root'
	group 'root'
	mode '0600'
	content "#{node['ba']['password']},#{node['ba']['account']},#{node['ba']['uid']}"
	action :create
end

# service start apiserver first
# and then scheduler and controller-manager

