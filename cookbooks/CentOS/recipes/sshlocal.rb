#
# Cookbook:: CentOS
# Recipe:: sshlocal
#
# Copyright:: 2017, The Authors, All Rights Reserved.

template '/etc/ssh/sshd_config' do
    source 'sshd_config.erb'
    mode '0600'
    owner 'root'
    group 'root'
    #variables(options: openssh_server_options)
    notifies :run, 'execute[sshd-config-check]', :immediately
    notifies :restart, 'service[ssh]'
end

execute 'sshd-config-check' do
    command '/usr/sbin/sshd -t'
    action :nothing
end

service 'ssh' do
    service_name 'sshd'
    supports value_for_platform_family(
        %w(debian rhel fedora aix) => [:restart, :reload, :status],
        %w(arch) =>  [:restart],
        'default' => [:restart, :reload]
    )
    action value_for_platform_family(
        %w(aix) => [:start],
        'default' => [:enable, :start]
    )
end