define :automysqlbackup,
    :db_name => nil, :db_user => nil, :db_password => nil,
    :backup_dir => "/opt/base/backup",
    :config_dir => "/etc/automysqlbackup" do

    backup_config_file = "#{params[:config_dir]}/#{params[:name]}.conf"

    template backup_config_file do
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

    template "/etc/cron.daily/#{params[:name]}.cron" do
        source "run_myserver_backup.erb"
        owner "root"
        group "root"
        mode 0755
        variables(
            :config_file => backup_config_file,
            :backup_dir => params[:backup_dir]
        )
    end
end
