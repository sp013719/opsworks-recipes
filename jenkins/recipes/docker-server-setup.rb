bash 'install-ant' do
	user 'root'
	code <<-EOH
	yum -y update
	yum -y install java
	yum -y install ant
	EOH
end

#install docker
bash 'install-docker' do
	user 'root'
	code <<-EOH
	yum -y install docker
	wget https://get.docker.com/builds/Linux/x86_64/docker-1.8.3
	chmod 700 docker-1.8.3
    mv docker-1.8.3 /usr/bin/docker -f
	sed -i '9c OPTIONS="--default-ulimit nofile=1024:4096 -H tcp://0.0.0.0:4243 -H unix:///var/run/docker.sock"' /etc/sysconfig/docker
	service docker restart
	EOH
	notifies :run, 'bash[setup-slave-image]'
end

#put cron job
template "/etc/cron.daily/docker-clean.sh" do
      mode "0755"
      owner "root"
      source "docker-clean.sh.erb"
end

bash 'setup-slave-image' do
	user 'root'
	code <<-EOH
	docker pull philpep/jenkins-slave:jessie
	EOH
	action :nothing
end

Chef::Log.info("***************** Jenkins docker server setup finished **************")
