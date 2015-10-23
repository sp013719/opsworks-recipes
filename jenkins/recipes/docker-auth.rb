include_recipe "slave-setup"

bash 'docker-login' do
	user 'jenkins'
	cwd '/home/jenkins'
	code <<-EOH
	docker login -u #{node['docker-registry']['username']} -p #{node['docker-registry']['password']} -e yoyo@trend.com dcsrd-docker-registry.trendmicro.com
	EOH
end
