#
# Cookbook:: CentOS
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

node['CentOS']['Packages'].each do |p|
    package "#{p}" do
        action :install
    end
end

node['CentOS']['Users'].each do |usr|
    #Chef::Recipe.send(:include, OpenSSLCookbook::RandomPassword)
    
    #password = node['CentOS']['InitPW']
    #salt = random_password(length: 10)
    #crypt_password = password.crypt("$6$#{salt}")
    
    user_home = "/home/#{usr}"

    user "#{usr}" do
      home user_home
      shell '/bin/bash'
      #password crypt_password
      action :create
      manage_home true
    end

    group "#{usr}" do
      members "#{usr}"
      action :create
    end
end

node['CentOS']['SuperUsers'].each do |susr|
    group 'wheel' do
      members "#{susr}"
      action :create
      append true
    end
end


#include_recipe "CentOS::sshlocal"

