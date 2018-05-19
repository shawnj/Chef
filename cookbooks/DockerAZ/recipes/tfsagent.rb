passwords = data_bag_item('test', 'pw')

docker_registry 'Azure Container Repo' do
  serveraddress node['DockerAZ']['ACRUrl']
  username node['DockerAZ']['ACRUser']
  password passwords["#{node['DockerAZ']['ACRUser']}"]
  email 'docker-internal@none.com'
end

docker_image 'testregistry.azurecr.io/tfsagent' do
  action :pull
  tag 'latest'
  notifies :redeploy, 'docker_container[tfsagent]', :immediately
end

docker_container 'tfsagent' do
  repo 'testregistry.azurecr.io/tfsagent'
  command '/bin/sh -c "/myagent/config.sh remove && /myagent/config.sh --unattended --acceptTeeEula && /myagent/bin/Agent.Listener"'
  env ["VSTS_AGENT_INPUT_PASSWORD=#{passwords[node['DockerAZ']['VSTS_AGENT_INPUT_USERNAME']]}", "VSTS_AGENT_INPUT_USERNAME=#{node['DockerAZ']['VSTS_AGENT_INPUT_USERNAME']}", "VSTS_AGENT_INPUT_URL=#{node['DockerAZ']['VSTS_AGENT_INPUT_URL']}", "VSTS_AGENT_INPUT_POOL=#{node['DockerAZ']['VSTS_AGENT_INPUT_POOL']}", "VSTS_AGENT_INPUT_AUTH=#{node['DockerAZ']['VSTS_AGENT_INPUT_AUTH']}"]
  tag 'latest'
  action :run
end
