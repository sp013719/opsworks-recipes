include_recipe 'kubernetes-rhel::minion-setup'
include_recipe 'kubernetes-rhel::flanneld-init'
include_recipe 'kubernetes-rhel::docker-engine'

bash 'start_flanneld_and_docker' do
	user 'root'
	code <<-EOH
	mkdir /run/flannel/
	systemctl daemon-reload	
	service flanneld start
	systemctl daemon-reload
	service docker start
	EOH
#	notifies :start, 'service[kubelet]', :delayed
#	notifies :start, 'service[kube-proxy]', :delayed
end

#service "kubelet" do
#	action :nothing
#end
#
#service "kube-proxy" do
#	action :nothing
#end
