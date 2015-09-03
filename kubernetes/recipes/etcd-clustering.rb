private_ip = node['opsworks']['instance']['private_ip']
hostname = node['opsworks']['instance']['hostname']
members = Array.new

node['opsworks']['layers']['etcd']['instances'].each do |inst|
	members << inst[0]+"=http://"+inst[1][:private_ip]+":7001"
end

template "/root/etcd_static_bootstrap.sh" do
	mode "0755"
	owner "root"
	source "etcd_static_bootstrap.sh.erb"
	variables ({
		:hostname => hostname,
		:members => members.join(','),
		:private_ip => private_ip,
		:token_postfix => node[:token]
	})
	notifies :stop, "service[etcd]", :delayed
end

service 'etcd' do
    action :nothing
	notifies :run, "bash[etcd_bootstrap]", :delayed
end

bash 'etcd_bootstrap' do
	user 'root'
	cwd '/root'
	code <<-EOH
	rm -rf #{hostname}.etcd
	./etcd_static_bootstrap.sh
	EOH
	action :nothing
end
