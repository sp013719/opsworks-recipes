service 'tomcat' do
    service_name 'tomcat7'
    supports :restart => true, :reload => true, :status => true
    action :nothing
end

bash 'tomcat-resource-config' do
	user 'root'
	cwd '/etc/tomcat7/Catalina/localhost/'
	code <<-EOH
	sed -i '5c \\            maxActive=\"30\" maxIdle=\"5\" maxWait=\"1000\"' ROOT.xml
	sed -i '5a \\            validationQuery=\"SELECT 1\" testOnBorrow=\"true\"' ROOT.xml
	sed -i '6a \\            removeAbandoned=\"true\" removeAbandonedTimeout=\"30\"' ROOT.xml
	chown tomcat ROOT.xml
	EOH
	notifies :restart, 'service[tomcat]'
end

