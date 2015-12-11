include_recipe 'kubernetes-rhel::repo-setup'

bash 'wait_a_moment' do
	user 'root'
	code <<-EOH
	yum -d0 -e0 -y install etcd
	EOH
end

#package 'etcd' do
#	action :nothing
#end

template '/etc/etcd/etcd.conf' do
	source "etcd.conf.erb"
	mode "0755"
	owner "root"
	#subscribes :create, "package[etcd]", :delayed
	subscribes :create, "bash[wait_a_moment]", :delayed
	notifies :start, "service[etcd]", :delayed
end

service "etcd" do
	action :nothing
end

