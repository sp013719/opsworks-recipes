driver_class = case deploy[:database][:type]
  when "mysql"
    'com.mysql.jdbc.Driver'
  when "postgresql"
    'org.postgresql.Driver'
  else
    ''
  end


template 'tomcat server configuration for Omnibus' do
	path	'/etc/tomcat7.0/Catalina/localhost/ROOT.xml'
	source 	'tomcat-context.xml.erb'
	owner	'tomcat'
	group	'tomcat'
	mode	0640
	variables ({
		:resource_name => node['opsworks_java']['datasources']['root'],
		:application => 'root',
		:driver_class => driver_class
	})
	notifies :restart, 'tomcat'
end

