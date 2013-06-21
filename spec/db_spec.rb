require_relative "spec_helper"

describe "openstack-compute-baremetal::db" do
  it "creates database and user" do
    ::Chef::Recipe.any_instance.should_receive(:db_create_with_user).
      with "compute-baremetal", "nova_bm", "novabm-pass"
    converge
  end

  def converge
    ::Chef::Recipe.any_instance.stub(:db_password).with("nova_bm").
      and_return "novabm-pass"
    ::ChefSpec::ChefRunner.new(::UBUNTU_OPTS).converge "openstack-compute-baremetal::db"
  end
end
