include_recipe 'kubernetes-rhel::repo-setup'

package 'flannel'

etcd_endpoint="http://root:#{node['etcd']['password']}@#{node['etcd']['elb_url']}"

template "/etc/sysconfig/flanneld" do
	mode "0755"
	owner "root"
	source "flanneld.erb"
	variables ({
		:elb_url => etcd_endpoint,
	})
	notifies :start, 'service[flanneld]', :delayed
	subscribes :create, "package[flannel]", :delayed
end


service "flanneld" do
	action :nothing
end
