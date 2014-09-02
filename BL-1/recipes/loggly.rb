template "/etc/rsyslog.d/22-loggly.conf" do
    source "rsyslog-main.erb"
    mode "0644"
    notifies :restart, "service[rsyslog]"
end

service "rsyslog" do
    supports :restart => true, :reload => true, :status => true
    action [:enable, :start]
end
