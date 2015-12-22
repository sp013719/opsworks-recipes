bash 'start_flanneld_and_docker' do
	user 'root'
	code <<-EOH
	systemctl daemon-reload	
	service flanneld start
	ls /run/flannel/
	service flanneld restart
	ls /run/flannel/
	sleep 5
	systemctl daemon-reload
	ls /usr/lib/systemd/system/docker.service
	service docker start
	EOH
	notifies :start, 'service[kubelet]', :delayed
	notifies :start, 'service[kube-proxy]', :delayed
end

service "kubelet" do
	action :nothing
end

service "kube-proxy" do
	action :nothing
end
