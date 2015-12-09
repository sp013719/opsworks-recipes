execute 'yum-update' do
	command 'yum -y update'
	notifies :install, "package[etcd]", :delayed
end

package 'etcd' do
	action :nothing
	notifies :start, "service[etcd]", :delayed
end

service "etcd" do
	action :enable
end

