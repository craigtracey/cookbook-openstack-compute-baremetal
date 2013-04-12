cookbook-nova-baremetal
=======================

This cookbook and LWRP provides baremetal "hypervisor" support for OpenStack, beginning with the Grizzly release. It is intended to be used in conjunction with the openstack cookbooks supported by Opscode. But, as many of the Openstak repositories have a common lineage, this may work for other repositories as well.

Requirements
============
- [Chef 11](http://www.opscode.com/chef/install/) (required in order to take advantage of template partials)
- [Opscode Chef for Openstack](http://www.opscode.com/solutions/chef-openstack/)

Note
====

At present time, the Opscode repositories have not been ported forward to Grizzly.  For some of that support, checkout [my forks](http://github.com/craigtracey/openstack-chef-repo).

Examples
========
The following is an example of a data bag item for provisioning baremetal node capacity:
```json
{
  "id": "bm-node01",
  "ip_address": "10.1.1.1",
  "service_host": "node-bm-compute01",
  "cpus": 24,
  "memory_mb": 122880,
  "local_gb": 50,
  "prov_mac_address": "AA:BB:CC:DD:EE:FF:00",
  "pm_address": "10.2.1.1",
  "pm_user": "root",
  "pm_password": "calvin"
}
```
