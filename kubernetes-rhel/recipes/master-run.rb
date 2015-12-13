include_recipe 'kubernetes-rhel::master-setup'
#include_recipe 'kubernetes-rhel::flanneld'
include_recipe 'kubernetes-rhel::flanneld-init' 
#version newer than 0.5.2 won't pass etcd URL with BA

# ignore this if you don't want flanneld working on master node
#service 'flanneld' do
#	action :start
#end
bash 'start_flanneld' do
  user 'root'
  code <<-EOH
  service flanneld start
  EOH
end

service "kube-apiserver" do
	action :start
	notifies :start, 'service[kube-scheduler]', :delayed
	notifies :start, 'service[kube-controller-manager]', :delayed
end

service "kube-scheduler" do
	action :nothing
end

service "kube-controller-manager" do
	action :nothing
end
