docker_volume 'jenkinsdata' do
  action :create
end

passwords = data_bag_item('test', 'pw')

docker_registry 'Azure Container Repo' do
  serveraddress node['DockerAZ']['ACRUrl']
  username node['DockerAZ']['ACRUser']
  password passwords["#{node['DockerAZ']['ACRUser']}"]
  email 'docker-internal@none.com'
end

docker_image 'testregistry.azurecr.io/jenkins' do
  action :pull
  tag 'latest'
  notifies :redeploy, 'docker_container[jenkins8080]', :immediately
end

docker_container 'jenkins8080' do
  repo 'testregistry.azurecr.io/jenkins'
  tag 'latest'
  volumes ['jenkinsdata:/var/jenkins_home']
  port '80:8080'
  action :run
end