package "docker-io" do
	action :install
	notifies :run, 'bash[update-docker]', :delayed
end


bash 'update-docker' do
	user 'root'
	cwd '/tmp'
	code <<-EOH
	wget https://get.docker.com/builds/Linux/x86_64/docker-1.6.2 -O /usr/bin/docker
	EOH

	action :nothing
end


service "docker" do
	action :disable
end


template "/etc/sysconfig/docker" do
    mode "0644"
    owner "root"
    source "docker.erb"
end
