#
# Cookbook:: Docker
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

docker_installation_package 'docker-ce' do
    action :create
end

docker_service_manager 'default' do
    host ['tcp://0.0.0.0:2376', 'unix:///var/run/docker.sock']
    action [:start]
    insecure_registry 'nexus.example.com:8082'
end
