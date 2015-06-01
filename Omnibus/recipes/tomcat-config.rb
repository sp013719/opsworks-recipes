service 'tomcat' do
    service_name 'tomcat7'
    supports :restart => true, :reload => true, :status => true
    action :nothing
end

bash 'tomcat-resource-config' do
	user 'root'
	cwd '/etc/tomcat7/Catalina/localhost/'
	code <<-EOH
	LineNum=$(grep -n "maxActive" ROOT.xml | awk 'BEGIN {FS=":"} {print $1}')
	sed -i ''"$LineNum"'c \\            maxActive=\"30\" maxIdle=\"5\" maxWait=\"1000\"' ROOT.xml
	sed -i ''"$LineNum"'a \\            validationQuery=\"SELECT 1\" testOnBorrow=\"true\"' ROOT.xml
	sed -i ''"$(($LineNum+1))"'a \\            removeAbandoned=\"true\" removeAbandonedTimeout=\"30\"' ROOT.xml
	EOH
	notifies :restart, 'service[tomcat]'
end

