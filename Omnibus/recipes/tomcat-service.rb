service 'tomcat' do
	service_name 'tomcat7'
	supports :restart => true, :reload => true, :status => true
	action :nothing
end
