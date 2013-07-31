#
# Cookbook Name:: openstack-compute-baremetal
# Recipe:: db
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

db_pass = db_password "nova_bm"

db_create_with_user("compute-baremetal",
  "nova_bm",
#  node["openstack"]["compute"]["baremetal"]["db"]["username"],
  db_pass
)
