#require_relative "spec_helper"
#
#describe "openstack-compute-baremetal::api" do
#
#
#  before { image_stubs }
#
#
#
#  describe "ubuntu" do
#    before do
#      @chef_run = ::ChefSpec::ChefRunner.new ::UBUNTU_OPTS
#      @chef_run.converge "openstack-compute-baremetal::setup"
#    end
#
#    it "installs nova baremetal packages" do
#      expect(@chef_run).to upgrade_package "nova-baremetal"
#      expect(@chef_run).to upgrade_package "open-iscsi"
#    end
#
#    it "installs ipmitool when power_manager is ipmi" do
#      chef_run = ::ChefSpec::ChefRunner.new ::UBUNTU_OPTS
#      chef_run.node.set["openstack"]["compute"]["baremetal"]["power_manager"] = "ipmi"
#      chef_run.converge "openstack-compute-baremetal::setup"
#
#      expect(chef_run).to upgrade_package "ipmitool"
#    end
#  end
#
#      describe "policy.json" do
#      before do
#        @file = @chef_run.template "/etc/glance/policy.json"
#      end
#
#      it "has proper owner" do
#        expect(@file).to be_owned_by "glance", "glance"
#      end
#
#      it "has proper modes" do
#        expect(sprintf("%o", @file.mode)).to eq "644"
#      end
#
#      it "notifies image-api restart" do
#        expect(@file).to notify "service[image-api]", :restart
#      end
#    end
#
#
#
#
#
#
#
#
#
#
#  chef_run = ::ChefSpec::ChefRunner.new ::UBUNTU_OPTS
#      chef_run.converge "openstack-compute-baremetal::api"
#
#      expect(chef_run).not_to include_recipe "openstack-common::logging"
#    end
#
#    expect_installs_python_keystone
#
#    expect_installs_curl
#
#    expect_installs_ubuntu_glance_packages
#
#    it "starts glance api on boot" do
#      expect(@chef_run).to set_service_to_start_on_boot "glance-api"
#    end
#
#    expect_creates_glance_dir
#
#    expect_creates_cache_dir
#
#    describe "policy.json" do
#      before do
#        @file = @chef_run.template "/etc/glance/policy.json"
#      end
#
#      it "has proper owner" do
#        expect(@file).to be_owned_by "glance", "glance"
#      end
#
#      it "has proper modes" do
#        expect(sprintf("%o", @file.mode)).to eq "644"
#      end
#
#      it "notifies image-api restart" do
#        expect(@file).to notify "service[image-api]", :restart
#      end
#    end
#
#    describe "glance-api.conf" do
#      before do
#        @file = @chef_run.template "/etc/glance/glance-api.conf"
#      end
#
#      it "has proper owner" do
#        expect(@file).to be_owned_by "glance", "glance"
#      end
#
#      it "has proper modes" do
#        expect(sprintf("%o", @file.mode)).to eq "644"
#      end
#
#      it "template contents" do
#        pending "TODO: implement"
#      end
#
#      it "notifies image-api restart" do
#        expect(@file).to notify "service[image-api]", :restart
#      end
#    end
#
#    describe "glance-api-paste.ini" do
#      before do
#        @file = @chef_run.template "/etc/glance/glance-api-paste.ini"
#      end
#
#      it "has proper owner" do
#        expect(@file).to be_owned_by "glance", "glance"
#      end
#
#      it "has proper modes" do
#        expect(sprintf("%o", @file.mode)).to eq "644"
#      end
#
#      it "template contents" do
#        pending "TODO: implement"
#      end
#
#      it "notifies image-api restart" do
#        expect(@file).to notify "service[image-api]", :restart
#      end
#    end
#
#    describe "glance-cache.conf" do
#      before do
#        @file = @chef_run.template "/etc/glance/glance-cache.conf"
#      end
#
#      it "has proper owner" do
#        expect(@file).to be_owned_by "glance", "glance"
#      end
#
#      it "has proper modes" do
#        expect(sprintf("%o", @file.mode)).to eq "644"
#      end
#
#      it "template contents" do
#        pending "TODO: implement"
#      end
#
#      it "notifies image-api restart" do
#        expect(@file).to notify "service[image-api]", :restart
#      end
#    end
#
#    describe "glance-cache-paste.ini" do
#      before do
#        @file = @chef_run.template "/etc/glance/glance-cache-paste.ini"
#      end
#
#      it "has proper owner" do
#        expect(@file).to be_owned_by "glance", "glance"
#      end
#
#      it "has proper modes" do
#        expect(sprintf("%o", @file.mode)).to eq "644"
#      end
#
#      it "template contents" do
#        pending "TODO: implement"
#      end
#
#      it "notifies image-api restart" do
#        expect(@file).to notify "service[image-api]", :restart
#      end
#    end
#
#    describe "glance-scrubber.conf" do
#      before do
#        @file = @chef_run.template "/etc/glance/glance-scrubber.conf"
#      end
#
#      it "has proper owner" do
#        expect(@file).to be_owned_by "glance", "glance"
#      end
#
#      it "has proper modes" do
#        expect(sprintf("%o", @file.mode)).to eq "644"
#      end
#
#      it "template contents" do
#        pending "TODO: implement"
#      end
#    end
#
#    it "has glance-cache-pruner cronjob running every 30 minutes" do
#      cron = @chef_run.cron "glance-cache-pruner"
#
#      expect(cron.command).to eq "/usr/bin/glance-cache-pruner"
#      expect(cron.minute).to eq "*/30"
#    end
#
#    it "has glance-cache-cleaner to run at 00:01 each day" do
#      cron = @chef_run.cron "glance-cache-cleaner"
#
#      expect(cron.command).to eq "/usr/bin/glance-cache-cleaner"
#      expect(cron.minute).to eq "01"
#      expect(cron.hour).to eq "00"
#    end
#
#    describe "glance-scrubber-paste.ini" do
#      before do
#        @file = @chef_run.template "/etc/glance/glance-scrubber-paste.ini"
#      end
#
#      it "has proper owner" do
#        expect(@file).to be_owned_by "glance", "glance"
#      end
#
#      it "has proper modes" do
#        expect(sprintf("%o", @file.mode)).to eq "644"
#      end
#
#      it "template contents" do
#        pending "TODO: implement"
#      end
#    end
#
#    it "uploads qcow images" do
#      opts = {
#        :step_into => ["openstack-compute-baremetal_image"]
#      }
#      chef_run = ::ChefSpec::ChefRunner.new ::UBUNTU_OPTS.merge(opts) do |n|
#        n.set["openstack"]["image"] = {
#          "image_upload" => true,
#          "upload_images" => [
#            "image1"
#          ],
#          "upload_image" => {
#            "image1" => "http://example.com/image.qcow2"
#          }
#        }
#      end
#      chef_run.converge "openstack-compute-baremetal::api"
#      cmd = "glance --insecure " \
#            "-I glance " \
#            "-K glance-pass " \
#            "-T service " \
#            "-N https://127.0.0.1:35357/v2.0 " \
#            "image-create " \
#            "--name image1 " \
#            "--is-public true " \
#            "--container-format bare "\
#            "--disk-format qcow2 " \
#            "--location http://example.com/image.qcow2"
#
#      expect(chef_run).to execute_command cmd
#    end
#  end
#end
