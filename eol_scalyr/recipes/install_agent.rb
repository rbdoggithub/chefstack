bash 'scalyr_agent_install' do
        code <<-EOH
cd /tmp/
#/bin/curl -s -O https://www.scalyr.com/scalyr-repo/stable/latest/scalyr-repo-bootstrap-1.2.1-1.noarch.rpm
/usr/bin/curl -s -O https://www.scalyr.com/scalyr-repo/stable/latest/scalyr-repo-bootstrap-1.2.1-1.noarch.rpm
yum remove -y scalyr-repo scalyr-repo-bootstrap
yum install -y --nogpgcheck /tmp/scalyr-repo-bootstrap-1.2.1-1.noarch.rpm
yum install -y scalyr-repo
yum install -y scalyr-agent-2
service scalyr-agent-2 start
        EOH
        not_if {::File.exists?("/etc/init.d/scalyr-agent-2")}
end

