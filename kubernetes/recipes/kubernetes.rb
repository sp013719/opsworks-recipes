bash 'install_kubernetes' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
  wget https://github.com/GoogleCloudPlatform/kubernetes/releases/download/v0.18.2/kubernetes.tar.gz
  tar zxvf kubernetes.tar.gz
  cd kubernetes/server
  tar zxvf kubernetes-server-linux-amd64.tar.gz
  cd kubernetes/server/bin
  mv * /usr/local/bin
  EOH
end
