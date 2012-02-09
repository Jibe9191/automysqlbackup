define :automysqlbackup, :db_name => nil, :db_user => nil, :db_password => nil, :backup_dir => nil, :dry_run => false do

    template "#{node[:automysqlbackup][:config_dir]}/#{params[:name]}.conf" do
        source "myserver.conf.erb"
        owner "root"
        group "root"
        mode 0600
        variables(
           :db_name => params[:db_name],
           :db_user => params[:db_user],
           :db_password => params[:db_password],
           :backup_dir => params[:backup_dir]
        )
    end

end
