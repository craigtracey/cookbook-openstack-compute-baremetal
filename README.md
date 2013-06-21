Description
===========

This cookbook installs the baremetal driver for the OpenStack Compute service **Nova** and is part of the OpenStack reference deployment Chef for OpenStack. The [openstack-chef-repo](http://github.com/stackforge/openstack-chef-repo) contains documentation for using this cookbook in the context of a full OpenStack deployment.

Requirements
============

* Chef 11 or higher required.

Cookbooks
---------

The following cookbooks are dependencies:

* openstack-common
* openstack-compute

Usage
=====

db
--------
- Configures the OpenStack compute baremetal database components

setup
-----
- Sets up all configuration needed for OpenStack compute  baremetal driver use
- Includes recipes for configuring the boot manager as well as for defining baremetal nodes

pxe
---

nodes
-----
- Provisions any nodes found in the openstack["compute"]["baremetal"]["nodes"]["databag"] databag 


Attributes
==========

Openstack Compute attributes are in the attribute namespace ["openstack"]["compute"]["baremetal"].

* `openstack["compute"]`
* `openstack["compute"]["baremetal"]["boot_method"]` - the type of boot method to use. Choices are 'tilera' and 'pxe'. Default: 'pxe'
* `openstack["compute"]["baremetal"]["power_manager"]` - the type of power manager to use. Choices are 'tilera' and 'ipmi'. Defaul: 'ipmi'
* `openstack["compute"]["baremetal"]["deploy_kernel"]` - the OpenStack Image UUID of the deployment kernel to use
* `openstack["compute"]["baremetal"]["deploy_ramdisk"]` - the OpenStack Image UUID of the deployment ramdisk to use
* `openstack["compute"]["baremetal"]["db"]["username"]` - the name of the database user for OpenStack Compute baremetal database. Default: 'nova_bm'
* `openstack["compute"]["baremetal"]["packages"]` = the list of packges necessary for installing the baremetal driver
* `openstack["compute"]["baremetal"]["imagebuild_packages"]` = the packages necessary to install an image on a baremetal compute host

PXE
---
* `openstack["compute"]["baremetal"]["pxe"]["packages"]` - the platform-specific packages necessary to install PXE.
* `openstack["compute"]["baremetal"]["pxe"]["tftproot"]` - the tftproot directory used by the DNS and TFTP servers. Default: '/tftpboot'
* `openstack["compute"]["baremetal"]["pxe"]["config_dir"]` - the PXE configuration directory. Default: '/tftpboot/pxelinux.cfg'
* `openstack["compute"]["baremetal"]["pxe"]["dhcp_range"]` - range of IP's that dnsmasq uses to PXE boot hosts
* `openstack["compute"]["baremetal"]["pxe"]["static_dhcp"]` - if desired, DHCP can be configured to provide static IP's to baremetal hosts. Default: false 
* `openstack["compute"]["baremetal"]["nodes"]["databag"]` - the nodes recipe will provision any nodes found in this databag. Default: nil

Testing
=====

This cookbook is using [ChefSpec](https://github.com/acrmp/chefspec) for
testing. Run the following before commiting. It will run your tests,
and check for lint errors.

    $ ./run_tests.bash

License and Author
==================

|                      |                                                    |
|:---------------------|:---------------------------------------------------|
| **Author**           |  Craig Tracey (<craigtracey@gmail.com>)            |
|                      |                                                    |
| **Copyright**        |  Copyright (c) 2013, Craig Tracey                  |

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
