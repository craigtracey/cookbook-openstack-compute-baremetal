#
# Cookbook Name:: baremetal
# Provider:: node
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

require 'chef/mixin/shell_out'
include Chef::Mixin::ShellOut

private
def generate_creds(res)
  ks_endpoint = res.keystone_admin_endpoint
  keystone_url = ks_endpoint['scheme'] + "://" + ks_endpoint['host'] + ':' + ks_endpoint['port'] + '/' + ks_endpoint['path']
  return {
    'OS_TENANT_NAME' => res.auth_tenant,
    'OS_USERNAME' => res.auth_user,
    'OS_AUTH_URL' => keystone_url,
    'OS_PASSWORD' => res.auth_password }
end

action :create do

  optional_args = [
    'pm_address',
    'pm_user',
    'pm_password',
    'prov_vlan_id',
    'terminal_port' ]

  positional_args = [
    'service_host',
    'cpus',
    'memory_mb',
    'local_gb',
    'prov_mac_address' ]

  creds = generate_creds(new_resource)

  # first check to see if this node exists
  checkcmd = shell_out(['nova', 'baremetal-node-list'], :env => creds)
  if checkcmd.exitstatus == 0
    if ( checkcmd.stdout =~ /#{new_resource.prov_mac_address}/ )
      Chef::Log.info("Node with MAC address #{new_resource.prov_mac_address} already exists. Skipping.")
      next
    end
  else
    Chef::Log.error("Check for baremetal node with MAC failed '#{new_resource.prov_mac_address}' failed.")
  end

  cmdparams = ['nova', 'baremetal-node-create']
  optional_args.each do |arg|
    value = new_resource.instance_variable_get("@#{arg}")
    if !value.nil?
      cmdparams.concat ["--#{arg}", "#{value}" ]
    end
  end

  positional_args.each do |arg|
    value = new_resource.instance_variable_get("@#{arg}")
    if !value.nil?
      cmdparams.concat [ "#{value}" ]
    else
      raise "Missing attribute '#{arg}' for baremetal_node[#{new_resource.prov_mac_address}]"
    end
  end

  nodecmd = shell_out(cmdparams, :env => creds)
  node_id = nil
  if nodecmd.exitstatus == 0
    nodecmd.stdout.split(/$/).each do |line|
      parts = line.split(/\s+/)
      if parts[2] == 'id'
        node_id = parts[4]
        break
      end
    end

    Chef::Log.info("Created baremetal node '#{new_resource.prov_mac_address}' #{nodecmd.stderr}")
  else
    Chef::Log.error("Creation of baremetal node '#{new_resource.prov_mac_address}' failed.")
    next
  end

  interfaceparams = ['nova', 'baremetal-interface-add', node_id, new_resource.prov_mac_address]
  interfacecmd = shell_out(interfaceparams, :env => creds)
  if interfacecmd.exitstatus == 0
    Chef::Log.info("Created baremetal node interface '#{new_resource.prov_mac_address}'")
  else
    Chef::Log.error("Creation of baremetal node interface '#{new_resource.prov_mac_address}' failed.")
  end

end
