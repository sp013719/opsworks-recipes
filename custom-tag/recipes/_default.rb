require "net/http"
require "uri"

#get instance-id
uri = URI.parse("http://169.254.169.254/latest/meta-data/instance-id")
http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Get.new(uri.request_uri)
response = http.request(request)
instance_id = response.body


node[:dcs][:customtags].each do |tagKey, tagValue|
	execute "ec2tagdynamic" do
	   command ". /etc/profile && /opt/aws/bin/ec2tag #{instance_id} -t #{tagKey}=#{tagValue}"
	   action :run
	   ignore_failure true
	end
end

execute "ec2tagstatic" do
   command ". /etc/profile && /opt/aws/bin/ec2tag #{instance_id} -t owner=hideto"
   action :run
   ignore_failure true
end
