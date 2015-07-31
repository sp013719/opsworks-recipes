bash 'install_etcd' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
  wget --max-redirect 255 https://github.com/coreos/etcd/releases/download/v2.0.12/etcd-v2.0.12-linux-amd64.tar.gz
  tar zxvf etcd-v2.0.12-linux-amd64.tar.gz
  cd etcd-v2.0.12-linux-amd64
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
	subscribes :reload, "template[/root/etcd_enable_ba.sh]", :immediately	
end

template "/root/etcd_enable_ba.sh" do
    mode "0755"
    owner "root"
    source "etcd_enable_ba.sh.erb"
    variables :etcd_password => node[:etcd_password]
    notifies :run, "bash[ba_setup]", :delayed
end

bash 'ba_setup' do
    user 'root'
    cwd '/root'
    code <<-EOH
    tries=0
    while [ $tries -lt 10 ]; do
        sleep 1
        tries=$((tries + 1))
    done

    /root/etcd_enable_ba.sh

    EOH

    action :nothing
end

