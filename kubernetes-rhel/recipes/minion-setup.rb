include_recipe 'kubernetes-rhel::repo-setup'

package ['kubernetes-node']

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

