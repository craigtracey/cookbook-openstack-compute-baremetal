default["openstack"]["compute"]["baremetal"]["boot_method"] = "pxe"
default["openstack"]["compute"]["baremetal"]["power_manager"] = "ipmi"

default["openstack"]["compute"]["baremetal"]["deploy_kernel"] = nil
default["openstack"]["compute"]["baremetal"]["deploy_ramdisk"] = nil

default["openstack"]["compute"]["baremetal"]["db"]["name"] = "nova_bm"
default["openstack"]["compute"]["baremetal"]["db"]["username"] = "nova_bm"

case platform
when "ubuntu"
  default["openstack"]["compute"]["baremetal"]["packages"] = ["nova-baremetal", "ipmitool", "open-iscsi"]
  default["openstack"]["compute"]["baremetal"]["imagebuild_packages"] = ["busybox", "tgt", "qemu-kvm"]
  default["openstack"]["compute"]["baremetal"]["pxe"]["packages"] = ["syslinux", "dnsmasq"]
end

default["openstack"]["compute"]["baremetal"]["pxe"]["tftproot"] = "/tftpboot"
default["openstack"]["compute"]["baremetal"]["pxe"]["config_dir"] = "/tftpboot/pxelinux.cfg"
default["openstack"]["compute"]["baremetal"]["pxe"]["dhcp_range"] = "192.168.175.100,192.168.175.254"
default["openstack"]["compute"]["baremetal"]["pxe"]["dhcp_gateway"] = nil
default["openstack"]["compute"]["baremetal"]["pxe"]["static_dhcp"] = false

default["openstack"]["compute"]["baremetal"]["nodes"]["databag"] = nil
default["openstack"]["compute"]["baremetal"]["config_dir"] = "/etc/nova/conf.d"
