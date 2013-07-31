name              "openstack-compute-baremetal"
maintainer        "Craig Tracey"
maintainer_email  "craigtracey@gmail.com"
license           "Apache 2.0"
description       "The OpenStack Compute Baremetal Driver Chef Cookbook"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "7.0.0"

recipe            "config", ""
recipe            "database", ""
recipe            "default", ""
recipe            "nodes", ""
recipe            "pxe", ""
recipe            "setup", ""

%w{ ubuntu }.each do |os|
  supports os
end

depends "openstack-common", "~> 0.4.1"
depends "openstack-compute", "7.0.0"
