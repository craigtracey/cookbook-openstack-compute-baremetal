#
# Cookbook Name:: openstack-compute-baremetal
# Resource:: node
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

actions :create

# In earlier versions of Chef the LWRP DSL doesn't support specifying
# a default action, so you need to drop into Ruby.
def initialize(*args)
  super
  @action = :create
end

attribute :auth_uri, :kind_of => String, :required => true
attribute :bootstrap_token, :kind_of => String, :required => true

attribute :service_host, :kind_of => String, :required => true, :name_attribute => true
attribute :cpus, :kind_of => Integer
attribute :memory_mb, :kind_of => Integer
attribute :local_gb, :kind_of => Integer
attribute :prov_mac_address, :kind_of => String

attribute :pm_address, :kind_of => String
attribute :pm_user, :kind_of => String
attribute :pm_password, :kind_of => String
attribute :prov_vlan_id, :kind_of => String
attribute :terminal_port, :kind_of => String
