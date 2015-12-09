include_recipe 'kubernetes-rhel::repo-setup'

package 'etcd' do
	action :nothing
	notifies :start, "service[etcd]", :delayed
end

service "etcd" do
	action :nothing
end

