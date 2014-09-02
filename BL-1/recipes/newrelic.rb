if node['kernel']['machine'] == 'x86_64'
  machine = 'x86_64'
else
  machine = 'i386'
end


remote_file "#{Chef::Config['file_cache_path']}/newrelic-repo-5-3.noarch.rpm" do
  source "http://download.newrelic.com/pub/newrelic/el5/#{machine}/newrelic-repo-5-3.noarch.rpm"
  action :create_if_missing
end


package 'newrelic-repo' do
  source "#{Chef::Config['file_cache_path']}/newrelic-repo-5-3.noarch.rpm"
  provider Chef::Provider::Package::Rpm
  action :install
end


package "newrelic-sysmond" do
  action :install
end


bash "nrsysmond-config" do
  user "root"
  cwd "/tmp"
  code "nrsysmond-config --set license_key=bc601ba34e286544df84d72865e2023b9f425b5c"
  action :run
end


service "newrelic-sysmond" do
  supports :status => true, :start => true, :stop => true, :restart => true
  action :start
end
