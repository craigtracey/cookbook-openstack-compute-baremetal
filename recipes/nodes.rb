#
# Cookbook Name:: baremetal
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

if node["baremetal"]["nodes"]["databag"]

  ks_admin_endpoint = get_access_endpoint("keystone", "keystone", "admin-api")
  node_names = data_bag(node["baremetal"]["nodes"]["databag"])

  node_names.each do |name|

    bmnode = data_bag_item(node["baremetal"]["nodes"]["databag"], name)
    baremetal_node "#{bmnode['prov_mac_address']}" do
      keystone_admin_endpoint ks_admin_endpoint
      auth_tenant node["nova"]["service_tenant_name"]
      auth_user node["nova"]["service_user"]
      auth_password node["nova"]["service_pass"]

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
