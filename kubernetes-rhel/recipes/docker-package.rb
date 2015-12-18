include_recipe 'kubernetes-rhel::repo-setup'

template "/etc/yum.repos.d/docker.repo" do
	mode "0644"
    owner "root"
    source "docker.repo.erb"
    notifies :install, "package[docker-engine]", :delayed
#    notifies :run, "bash[install-docker-engine]", :delayed
end

package 'docker-engine' do
	action :nothing
	notifies :create, "template[/etc/sysconfig/docker]", :delayed
	notifies :create, "template[/usr/lib/systemd/system/docker.service]", :delayed
end

#bash 'install-docker-engine' do
#	user 'root'
#	code <<-EOH	
#	yum -y install docker-engine
#	EOH
#	action :nothing
#	notifies :create, "template[/etc/sysconfig/docker]", :delayed
#	notifies :create, "template[/usr/lib/systemd/system/docker.service]", :delayed
#end

template "/etc/sysconfig/docker" do
	mode "0644"
	owner "root"
	source "docker.erb"
	action :nothing
end

template "/usr/lib/systemd/system/docker.service" do
	mode "0644"
	owner "root"
	source "docker.service.erb"
	action :nothing
end
