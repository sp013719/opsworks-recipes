remote_file '/etc/yum.repos.d/jenkins-oc.repo' do
	source 'http://downloads.cloudbees.com/cjoc/latest/rpm/jenkins-oc.repo'
end

execute 'rpm-import' do 
	command 'rpm --import http://downloads.cloudbees.com/cjoc/latest/rpm/jenkins-ci.org.key'
end

bash 'update-and-install' do
	user 'root'
	code <<-EOH
	yum -y update
	yum -y install java
	yum -y install jenkins-oc
	chkconfig jenkins-oc --level 35 on
	EOH
	notifies :start, 'service[Jenkins-OC]'
end

service 'Jenkins-OC' do
	service_name 'jenkins-oc'
	supports :restart => true, :reload => true, :status => true, :start => true
	action :nothing
end
