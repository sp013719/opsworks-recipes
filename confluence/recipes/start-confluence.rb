execute "start-confluence" do
  command "/trend/atlassian/confluence/bin/start-confluence.sh"
  user "root"
  cwd "/"
  action :run
end
