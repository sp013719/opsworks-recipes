include_recipe 'kubernetes-rhel::master-setup'
include_recipe 'kubernetes-rhel::flanneld'

# ignore this if you don't want flanneld working on master node
service 'flanneld' do
	action :start
end

service "kube-apiserver" do
	action :start
	notifies :start, 'service[kube-sheduler]', :delayed
	notifies :start, 'service[kube-controller-manager]', :delayed
end

service "kube-sheduler" do
	action :nothing
end

service "kube-controller-manager" do
	action :nothing
end
