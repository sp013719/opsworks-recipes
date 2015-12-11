include_recipe 'kubernetes-rhel::repo-setup'

package ['kubernetes-node']

template "/etc/kubernetes/conf" do
	mode "0755"
	owner "root"
	source "minion-conf.erb"
	variables :master_endpoint => node['kubernetes']['master_url']
	subscribes :create, "package[kubernetes-node]", :delayed
end

template "/etc/kubernetes/kubelet" do
	mode "0775"
	owner "root"
	source 	"minion-kubelet.erb"
	variables :master_endpoint => node['kubernetes']['master_url']
	subscribes :create, "package[kubernetes-node]", :delayed
end


