execute "stop-jira" do
  command "/trend/atlassian/jira/bin/stop-jira.sh"
  user "root"
  cwd "/"
  action :run
end
