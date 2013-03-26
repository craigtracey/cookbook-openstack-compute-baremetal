name              "baremetal"
maintainer        "Craig Tracey"
maintainer_email  "craigtracey@gmail.com"
license           "Apache 2.0"
description       "The OpenStack Nova Compute Baremetal Driver"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "2013.1.1"

recipe            "database", ""
recipe		        "default", ""
recipe            "nodes", ""
recipe            "pxe", ""
recipe            "setup", ""

%w{ ubuntu }.each do |os|
  supports os
end

%w{ apt nova }.each do |dep|
  depends dep
end
