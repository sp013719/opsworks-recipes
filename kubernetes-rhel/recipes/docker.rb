include_recipe 'kubernetes-rhel::repo-setup'

package 'docker' do
	action :install
	notifies :create, "template[/etc/sysconfig/docker]", :delayed
	notifies :run, "bash[add-flanneld-in-docker]", :delayed
end

template "/etc/sysconfig/docker" do
	mode "0644"
	owner "root"
	source "docker.erb"
	action :nothing
end
#insert environment file after docker network environment file
bash 'add-flanneld-in-docker' do
    user 'root'
	cwd '/usr/lib/systemd/system'
    code <<-EOH
	LINE_NUM=$(sed -n "0,/docker-network/p" docker.service | wc -l)
	sed -i "${LINE_NUM}a EnvironmentFile=-/run/flannel/docker.env" docker.service
    EOH
    action :nothing
end

