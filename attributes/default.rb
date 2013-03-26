default["baremetal"]["boot_method"] = "pxe"
default["baremetal"]["power_manager"] = "ipmi"

default["baremetal"]["deploy_kernel"] = nil
default["baremetal"]["deploy_ramdisk"] = nil

default["baremetal"]["db"]["name"] = "nova_bm"
default["baremetal"]["db"]["username"] = "nova_bm"

default["baremetal"]["packages"] = ["nova-baremetal", "ipmitool", "open-iscsi"]
default["baremetal"]["imagebuild_packages"] = ["busybox", "tgt", "qemu-kvm"]

default["baremetal"]["pxe"]["packages"] = ["syslinux", "dnsmasq"]
default["baremetal"]["pxe"]["tftproot"] = "/tftpboot"
default["baremetal"]["pxe"]["config_dir"] = "/tftpboot/pxelinux.cfg"
default["baremetal"]["pxe"]["dhcp_range"] = "192.168.175.100,192.168.175.254" # if all static hosts, we sure to use just the subnet
default["baremetal"]["pxe"]["static_dhcp"] = false # right now this is all or none. move this into the data bag item

default["baremetal"]["nodes"]["databag"] = nil

default["baremetal"]["driver_template"] = "nova.baremetal.conf.erb"

default["baremetal"]["nova_template_data"] = {
  "cookbook" => "baremetal",
  "template" => node["baremetal"]["driver_template"],
  "variables" => {
    "baremetal_db_user" => node["baremetal"]["db"]["username"],
    "baremetal_db_password" => node["baremetal"]["db"]["password"],
    "baremetal_db_name" => node["baremetal"]["db"]["name"],
    "baremetal_boot_method" => node["baremetal"]["boot_method"],
    "baremetal_tftproot" => default["baremetal"]["pxe"]["tftproot"],
    "baremetal_power_manager" => node["baremetal"]["power_manager"],
    "baremetal_deploy_kernel" => node["baremetal"]["deploy_kernel"],
    "baremetal_deploy_ramdisk" => node["baremetal"]["deploy_ramdisk"]
  }
}
