remote_file "#{Chef::Config[:file_cache_path]}/aws-kinesis-agent-1.0-1.amzn1.noarch.rpm" do
    source "https://s3.amazonaws.com/streaming-data-agent/aws-kinesis-agent-1.0-1.amzn1.noarch.rpm"
    action :create
    notifies :install, 'rpm_package[aws-kinesis-agent]'
end


rpm_package "aws-kinesis-agent" do
    source "#{Chef::Config[:file_cache_path]}/aws-kinesis-agent-1.0-1.amzn1.noarch.rpm"
    notifies :enable, "service[aws-kinesis-agent]", :immediately
    notifies :create, "template[/etc/aws-kinesis/agent.json]"
end


template "/etc/aws-kinesis/agent.json" do
  cookbook "Omnibus"
  source "agent.json.erb"
  owner "root"
  group "root"
  mode 0644
  variables({
	:kinesis_access_key => node[:deploy]['root'][:environment_variables][:KINESIS_ACCESS_KEY],
	:kinesis_secret_key => node[:deploy]['root'][:environment_variables][:KINESIS_SECRET_KEY],
	:kinesis_stream_name => node[:deploy]['root'][:environment_variables][:KINESIS_STREAM_NAME],
	:kinesis_firehose_name => node[:deploy]['root'][:environment_variables][:KINESIS_FIREHOSE_NAME]
  })
  notifies :restart, 'service[aws-kinesis-agent]', :immediately
end


service 'aws-kinesis-agent' do
  action :nothing
end

