service "flanneld" do
	action :start
end

service "kube-apiserver" do
	action :start
	notifies :start 'service[kube-sheduler]', :delayed
	notifies :start 'service[kube-controller-manager]', :delayed
end

service "kube-sheduler" do
	action :nothing
end

service "kube-controller-manager" do
	action :nothing
end
