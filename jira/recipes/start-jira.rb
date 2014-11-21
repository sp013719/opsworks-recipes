execute "start-jira" do
  command "/trend/atlassian/jira/bin/start-jira.sh"
  user "root"
  cwd "/"
  action :run
end
