#
# Cookbook Name:: automysqlbackup
# Recipe:: default
#
# Copyright 2012, Srinivasan Raguraman
#
#

pkg_url = "#{node[:automysqlbackup][:package_url]}/#{node[:automysqlbackup][:package_name]}.tar.gz"
install_path = "#{node[:automysqlbackup][:install_location]}/#{node[:automysqlbackup][:package_name]}"
pkg_local_path = "#{install_path}.tar.gz"

package "tar"

remote_file pkg_local_path do
  source pkg_url
  mode "0755"
  not_if {File.exists?(pkg_local_path)}
end

directory install_path do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

execute "install automysqlbackup" do
  command "tar -xzvf #{pkg_local_path} -C #{install_path}"
  not_if {File.directory?(install_path)}
end
