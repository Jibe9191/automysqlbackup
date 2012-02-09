#
# Cookbook Name:: automysqlbackup
# Recipe:: default
#
# Copyright 2012, Srinivasan Raguraman
#
#

pkg_url = "#{node[:automysqlbackup][:package_url]}/#{node[:automysqlbackup][:package_name]}.tar.gz"
pkg_local_path = "#{node[:automysqlbackup][:install_location]}/#{node[:automysqlbackup][:package_name]}"
pkg_local_archive = "#{pkg_local_path}.tar.gz"

package "tar"

script "install_automysqlbackup" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
    tar -zxf "#{pkg_local_archive}"
    cd "#{node[:automysqlbackup][:package_name]}"
    ./install.sh < /dev/null
  EOH
  action :nothing
end

remote_file pkg_local_archive do
  source pkg_url
  mode "0755"
  checksum "4a295dd11c6ada8d2868bb65f860728f2e47c4a043c976b0ac4aac0ef20e9758"
  notifies :run, "script[install_automysqlbackup]", :immediately
end

automysqlbackup "sonar" do
  db_name "sonar"
  db_password "sonar"
  db_user "sonar"
  backup_dir "/tmp/backup"
  dryrun true
end

