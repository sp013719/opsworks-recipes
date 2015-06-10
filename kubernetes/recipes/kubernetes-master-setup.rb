if my_etcd_elb = node[:opsworks][:stack]['elb-load-balancers'].select{|elb| elb[:layer_id] == node[:opsworks][:layers]['etcd'][:id] }.first

    template "/etc/init.d/kubernetes-master" do
      mode "0755"
      owner "root"
      source "kubernetes-master.erb"
      variables({
	:etcd_url => my_etcd_elb[:dns_name],
	:cluster_cidr => node['kubernetes']['cluster_cidr']
      })
    end
end

