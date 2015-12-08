package 'etcd' do
	action :install
end

service "etcd" do
	action [:enable, :start]
end

