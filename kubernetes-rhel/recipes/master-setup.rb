include_recipe 'kubernetes-rhel::repo-setup'

etcd_endpoint="http://root:#{node['etcd']['password']}@#{node['etcd']['elb_url']}:80"
execute 'set_flanneld_CIDR_at_ETCD' do
	command "curl -L #{etcd_endpoint}/v2/keys/coreos.com/network/config -XPUT -d value=\"{\\\"Network\\\": \\\"#{node['kubernetes']['cluster_cidr']}\\\" }\""
end

package 'kubernetes-master', 'kubernetes-client'

template "/etc/kubernetes/apiserver" do
	mode "0755"
	owner "root"
	source "master-apiserver.conf.erb"
	variables({
		:etcd_server => "#{etcd_endpoint}",
		:ba_path => "/root/ba_file",
		:cluster_cidr => node['kubernetes']['cluster_cidr'],
		:cluster_name => "happy-k8s-cluster"
	})
	subscribes :create, "package[kubernetes-master]", :delayed
end

file "/root/ba_file" do
	owner 'root'
	group 'root'
	mode '0600'
	content "#{node['ba']['password']},#{node['ba']['account']},#{node['ba']['uid']}"
	action :create
end

