#
# Cookbook Name:: openstack-compute-baremetal
# Recipe:: setup
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

class ::Chef::Recipe
  include ::Openstack
end

node["openstack"]["compute"]["baremetal"]["packages"].each do |pkg|
  package pkg
end

config_dir = node["openstack"]["compute"]["baremetal"]["config_dir"]

execute "nova-baremetal-manage db sync" do
  command "nova-baremetal-manage --config-file #{config_dir}/nova-baremetal.conf db sync"

  action :run
end

service "nova-baremetal" do
  service_name  "nova-baremetal"
  supports      :status => true, :restart => true
  subscribes    :restart, ["template[/etc/nova/nova.conf]", "template[#{config_dir}/nova-baremetal.conf]"]

  action :enable
end

include_recipe "openstack-compute-baremetal::#{node["openstack"]["compute"]["baremetal"]["boot_method"]}"
