#
# Cookbook Name:: openstack-compute-baremetal
# Recipe:: nodes
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

nodes_data_bag = node["openstack"]["compute"]["baremetal"]["nodes"]["databag"]

if nodes_data_bag

  identity_endpoint = endpoint "identity-admin"
  bootstrap_token = secret "secrets", "openstack_identity_bootstrap_token"
  auth_uri = ::URI.decode identity_endpoint.to_s
  node_names = data_bag(nodes_data_bag)

  node_names.each do |name|

    bmnode = data_bag_item(nodes_data_bag, name)
    openstack_compute_baremetal_node bmnode['prov_mac_address'] do
      auth_uri auth_uri
      bootstrap_token bootstrap_token

      service_host bmnode['service_host']
      cpus bmnode['cpus']
      memory_mb bmnode['memory_mb']
      local_gb bmnode['local_gb']
      prov_mac_address bmnode['prov_mac_address']
      pm_address bmnode['pm_address']
      pm_user bmnode['pm_user']
      pm_password bmnode['pm_password']
      action :create
    end
  end

end
