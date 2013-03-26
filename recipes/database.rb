#
# Cookbook Name:: baremetal
# Recipe:: database
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

# Allow for using a well known db password
if node["developer_mode"]
  node.set_unless["baremetal"]["db"]["password"] = "nova_bm"
else
  node.set_unless["baremetal"]["db"]["password"] = secure_password
end

mysql_info = create_db_and_user("mysql",
                   node["baremetal"]["db"]["name"],
                   node["baremetal"]["db"]["username"],
                   node.set_unless["baremetal"]["db"]["password"])

node.default["baremetal"]["nova_template_data"]["variables"]["db_ipaddress"] = mysql_info["bind_address"]
