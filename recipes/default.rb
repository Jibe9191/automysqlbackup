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

execute "install automysqlbackup" do
  command "tar -xzvf #{pkg_local_path} -C #{node[:automysqlbackup][:install_location]}"
  not_if {File.directory?(install_path)}
end
