# -*- mode: ruby -*-:
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define :main do |main_config|
    main_config.vm.box = "precise64"
    main_config.vm.box_url = "http://files.vagrantup.com/precise64.box"
    main_config.vm.network "private_network", ip: "192.168.56.44"
    main_config.vm.host_name = "m1.loc"
    main_config.hostmanager.aliases = %w(m1.local)
    main_config.vm.synced_folder ".", "/vagrant", type: "nfs"
    main_config.vm.provision :shell, :path => "scripts/provision/provision.sh"
  end
  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--memory", "1048"]
    v.customize ["modifyvm", :id, "--cpus", "1"]
  end
  if Vagrant.has_plugin?("HostManager")
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.ignore_private_ip = false
  end
end
