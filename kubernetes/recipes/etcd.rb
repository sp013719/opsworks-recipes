bash 'install_etcd' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
  wget https://github.com/coreos/etcd/releases/download/v2.1.0-rc.0/etcd-v2.1.0-rc.0-linux-amd64.tar.gz
  tar zxvf etcd-v2.1.0-rc.0-linux-amd64.tar.gz
  cd etcd-v2.1.0-rc.0-linux-amd64
  cp etcd etcdctl /usr/local/bin
  EOH
end


template "/etc/init.d/etcd" do
	mode "0755"
	owner "root"
	source "etcd.erb"
end


service "etcd" do
	action [:enable, :start]
	subscribes :reload, "template[/etc/init.d/etcd]", :immediately
end

