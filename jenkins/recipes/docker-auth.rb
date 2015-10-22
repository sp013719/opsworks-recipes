execute 'docker-login' do
	user 'jenkins'
	cwd '/home/jenkins'
	command "docker login -u #{node['docker-registry']['username']} -p #{node['docker-registry']['password']} -e yoyo@trend.com dcsrd-docker-registry.trendmicro.com"
end
