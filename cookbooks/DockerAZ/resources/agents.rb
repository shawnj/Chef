property :number_of_agents, Integer, required: true

action :run  do
    loop_num = new_resource.number_of_agents

    while loop_num >= 0
      docker_container "tfsagent_#{loop_num}" do
        repo 'testregistry.azurecr.io/tfsagent'
        command '/bin/sh -c "/myagent/config.sh remove && /myagent/config.sh --unattended --acceptTeeEula && /myagent/bin/Agent.Listener"'
        env ["VSTS_AGENT_INPUT_PASSWORD=#{passwords[node['DockerAZ']['VSTS_AGENT_INPUT_USERNAME']]}", "VSTS_AGENT_INPUT_USERNAME=#{node['DockerAZ']['VSTS_AGENT_INPUT_USERNAME']}", "VSTS_AGENT_INPUT_URL=#{node['DockerAZ']['VSTS_AGENT_INPUT_URL']}", "VSTS_AGENT_INPUT_POOL=#{node['DockerAZ']['VSTS_AGENT_INPUT_POOL']}", "VSTS_AGENT_INPUT_AUTH=#{node['DockerAZ']['VSTS_AGENT_INPUT_AUTH']}"]
        tag 'latest'
        action :run_if_missing
      end
      loop_num -= loop_num
    end
end
