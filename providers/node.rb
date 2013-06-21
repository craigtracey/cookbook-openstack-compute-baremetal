#
# Cookbook Name:: openstack-compute-baremetal
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

  creds = {
    'OS_AUTH_TOKEN' => res.bootstrap_token,
    'OS_AUTH_URL' => res.auth_uri
  }

  node_updated = false
  interface_updated = false

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
      cmdparams.concat ["--#{arg}", value]
    end
  end

  positional_args.each do |arg|
    value = new_resource.instance_variable_get("@#{arg}")
    if !value.nil?
      cmdparams.concat [value]
    else
      new_resource.updated_by_last_action(false)
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

    node_updated = true
    Chef::Log.info("Created baremetal node '#{new_resource.prov_mac_address}' #{nodecmd.stderr}")
  else
    Chef::Log.error("Creation of baremetal node '#{new_resource.prov_mac_address}' failed.")
    next
  end

  interfaceparams = ['nova', 'baremetal-interface-add', node_id, new_resource.prov_mac_address]
  interfacecmd = shell_out(interfaceparams, :env => creds)
  if interfacecmd.exitstatus == 0
    interface_updated = true
    Chef::Log.info("Created baremetal node interface '#{new_resource.prov_mac_address}'")
  else
    Chef::Log.error("Creation of baremetal node interface '#{new_resource.prov_mac_address}' failed.")
  end

  # this is a bit more verbose than necessary but we need it to keep foodcritic happy
  if node_updated and interface_updated
    new_resource.updated_by_last_action(true)
  else
    new_resource.updated_by_last_action(false)
  end

end
