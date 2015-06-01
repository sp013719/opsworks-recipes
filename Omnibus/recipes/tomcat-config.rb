service 'tomcat' do
    service_name 'tomcat7'
    supports :restart => true, :reload => true, :status => true
    action :nothing
end

#driver_class = case node[:deploy]['root'][:database][:type]
#  when "mysql"
#    'com.mysql.jdbc.Driver'
#  when "postgresql"
#    'org.postgresql.Driver'
#  else
#    ''
#  end
#
#
#template 'tomcat server configuration for Omnibus' do
#	path	'/etc/tomcat7/Catalina/localhost/ROOT.xml'
#	source 	'tomcat-context.xml.erb'
#	owner	'tomcat'
#	group	'tomcat'
#	mode	0640
#	variables ({
#		:resource_name => node['opsworks_java']['datasources']['root'],
#		:application => 'root',
#		:driver_class => driver_class
#	})
#	notifies :restart, 'service[tomcat]'
#end


bash 'tomcat-resource-config' do
	user 'tomcat'
	cwd '/etc/tomcat7/Catalina/localhost/'
	code <<-EOH
	sed -i "5c \            maxActive=\"30\" maxIdle=\"5\" maxWait=\"1000\"" ROOT.xml
	sed -i "6i \            validationQuery=\"SELECT 1\" testOnBorrow=\"true\"" ROOT.xml
	sed -i "7i \            removeAbandoned=\"true\" removeAbandonedTimeout=\"30\"" ROOT.xml
	EOH
end

