#directory '/nexusdata' do
#    owner 'root'
#    group 'root'
#    mode '0755'
#    action :create
#end

docker_volume 'nexusdata' do
  action :create
end

docker_volume 'nexusblobs' do
    action :create
end

docker_image 'sonatype/nexus3' do
  action :pull
  tag '3.6.0'
end

docker_container 'nexus80' do
  repo 'sonatype/nexus3'
  tag '3.6.0'
  volumes ['nexusdata:/nexus-data', 'nexusblobs:/sonatype-work']
  port ['80:8081', '8082:8082']
  action :run
end
