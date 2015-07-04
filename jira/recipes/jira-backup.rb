template "/etc/cron.daily/jira-backup.sh" do
  cookbook "jira"
  source "jira-backup.sh.erb"
  owner "root"
  group "root"
  mode 0755
end
