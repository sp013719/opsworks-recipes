include_recipe 'kubernetes-rhel::minion-setup'
include_recipe 'kubernetes-rhel::flanneld-init'
include_recipe 'kubernetes-rhel::docker'

#service "flanneld" do 
#	action :start
#	notifies :start, 'service[docker]', :delayed
#end
bash 'start_flanneld' do
	user 'root'
	code <<-EOH
	service flanneld start
	EOH
	notifies :run, 'bash[reload-docker-service]', :delayed
end

bash 'reload-docker-service' do
	user 'root'
	code <<-EOH
	systemctl daemon-reload	
	EOH
	action :nothing
	notifies :start, 'service[docker]', :delayed
end


service "docker" do
	action :nothing
	notifies :start, 'service[kubelet]', :delayed
	notifies :start, 'service[kube-proxy]', :delayed
end

service "kubelet" do
	action :nothing
end

service "kube-proxy" do
	action :nothing
end
