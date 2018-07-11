directory '/etc/scalyr-agent-2'	do
	owner 'root'
	group 'root'
	mode '0755'
	action :create
end



template '/etc/scalyr-agent-2/agent.json' do
        source 'node_log_www.json.erb'
        owner 'root'
        group 'root'
        variables(
        api_key: '0lKxW849DUajlVwoqw1mnBkAJ95y_f4QyRuQRT4tt/Pc-',
        node_fqdn: node['fqdn']
        )

notifies :run, 'bash[scalyr_agent_reload]'
end




bash 'scalyr_agent_reload' do
        code <<-EOH
service scalyr-agent-2 restart
        EOH
        only_if {::File.exists?("/etc/init.d/scalyr-agent-2")}
        action :nothing
end


