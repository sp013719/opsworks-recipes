include_recipe 'kubernetes-rhel::repo-setup'

# only install flanneld, not start the service, because of the dependency
package 'flannel'

etcd_endpoint="http://root:#{node['etcd']['password']}@#{node['etcd']['elb_url']}"

template "/etc/sysconfig/flanneld" do
	mode "0755"
	owner "root"
	source "flanneld.erb"
	variables ({
		:etcd_url => etcd_endpoint,
	})
	subscribes :create, "package[flannel]", :delayed
end


