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

remote_file pkg_local_archive do
  source pkg_url
  mode "0755"
  not_if {File.exists?(pkg_local_archive)}
end

script "install_automysqlbackup" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
    tar -zxf "#{pkg_local_archive}"
    cd "#{node[:automysqlbackup][:package_name]}"
    ./install.sh < /dev/null
  EOH
end
