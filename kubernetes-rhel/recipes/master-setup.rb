include_recipe 'kubernetes-rhel::repo-setup'

package ['kubernetes-master', 'kubernetes-client']

template "/etc/kubelet/kubelet.conf" do
	mode "0755"
	owner "root"
	source "kubernetes-master.erb"
	variables({
		:etcd_url => node['etcd']['elb_url'],
		:cluster_cidr => node['kubernetes']['cluster_cidr'],
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


