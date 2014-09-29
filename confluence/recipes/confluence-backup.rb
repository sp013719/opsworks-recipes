template "/etc/cron.daily/confluence-backup.sh" do
  cookbook "confluence"
  source "confluence-backup.sh.erb"
  owner "root"
  group "root"
  mode 0755
end
