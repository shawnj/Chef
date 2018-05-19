#
# Cookbook:: CentOS
# Recipe:: sshkey
#
# Copyright:: 2017, The Authors, All Rights Reserved.

sshkeys = data_bag_item('ips_keys', 'users')

node['CentOS']['Users'].each do |usr|

    directory "/home/#{usr}/.ssh" do
      owner "#{usr}"
      group "#{usr}"
      mode '0700'
      action :create
    end
    
    if sshkeys["#{usr}"]["key"]
        template "/home/#{usr}/.ssh/authorized_keys" do
            source 'authorized_keys.erb'
            mode '0600'
            owner "#{usr}"
            group "#{usr}"
            only_if { ::File.exists?("/home/#{usr}")}
            variables(ssh_key: sshkeys["#{usr}"]["key"])
        end
    end 
end