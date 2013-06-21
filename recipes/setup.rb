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

db_user = node["openstack"]["compute"]["baremetal"]["db"]["username"]
db_pass = db_password "nova_bm"
sql_connection = db_uri("compute-baremetal", db_user, db_pass)

config_dir = node["openstack"]["compute"]["config_dir"]

directory config_dir do
  owner "root"
  group "root"
  mode 00755
  action :create
end

template "#{config_dir}/nova-baremetal.conf" do
  source "nova.baremetal.conf.erb"
  owner "root"
  group "root"
  mode 00755
  variables(
    :sql_connection => sql_connection,
    :boot_method => node["openstack"]["compute"]["baremetal"]["boot_method"],
    :tftproot => node["openstack"]["compute"]["baremetal"]["pxe"]["tftproot"],
    :power_manager => node["openstack"]["compute"]["baremetal"]["power_manager"],
    :deploy_kernel => node["openstack"]["compute"]["baremetal"]["deploy_kernel"],
    :deploy_ramdisk => node["openstack"]["compute"]["baremetal"]["deploy_ramdisk"]
  )
  notifies :restart, "service[nova-compute]", :delayed
end

execute "nova-baremetal-manage db sync" do
  command "nova-baremetal-manage --config-file #{config_dir}/nova-baremetal.conf db sync"
  action :run
end

include_recipe "openstack-compute-baremetal::#{node["openstack"]["compute"]["baremetal"]["boot_method"]}"

include_recipe "openstack-compute-baremetal::nodes"
