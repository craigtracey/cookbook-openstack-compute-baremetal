#
# Cookbook Name:: baremetal
# Recipe:: pxe
#
# Copyright 2013, Craig Tracey <craigtracey@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

node["baremetal"]["pxe"]["packages"].each do |pkg|
  package pkg
end

directory node["baremetal"]["pxe"]["tftproot"] do
  owner "root"
  group "root"
  mode 00755
  action :create
end

directory node["baremetal"]["pxe"]["config_dir"] do
  owner "root"
  group "root"
  mode 00755
  action :create
end

link "#{node["baremetal"]["pxe"]["tftproot"]}/pxelinux.0" do
  to "/usr/lib/syslinux/pxelinux.0"
end

static_dhcp_hosts = []
if node["baremetal"]["pxe"]["static_dhcp"]

  if node["baremetal"]["nodes"]["databag"]
    node_names = data_bag(node["baremetal"]["nodes"]["databag"])
    node_names.each do |name|
      bmnode = data_bag_item(node["baremetal"]["nodes"]["databag"], name)
      static_dhcp_hosts.push("#{bmnode['prov_mac_address']}:#{bmnode['ip_address']}")
    end
  else
    Chef::Log.warning("Attribute static_dhcp is true, but no data_bag provided")
  end
end

template "/etc/dnsmasq.d/nova-baremetal" do
  source "dnsmasq.conf.erb"
  variables(
    "static_dhcp_hosts" => static_dhcp_hosts
  )
end

service "dnsmasq" do
  supports :status => true, :restart => true
  action :enable
  subscribes :restart, "template[/etc/dnsmasq.d/nova-baremetal]"
end
