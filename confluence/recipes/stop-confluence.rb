execute "stop-confluence" do
  command "/trend/atlassian/confluence/bin/stop-confluence.sh"
  user "root"
  cwd "/"
  action :run
end
