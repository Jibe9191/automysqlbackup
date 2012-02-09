define :automysqlbackup, :database => nil, :db_user => nil, :db_password => nil do

    template "#{node[:automysqlbackup][:config_dir]}/#{params[:name]}" do
        source "myserver.conf.erb"
        owner "root"
        group "root"
        mode 0600
    end

end
