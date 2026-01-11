config.vm.provision "ansible" do |ansible|
  ansible.playbook = "provision/site.yml"
  ansible.inventory_path = "provision/inventory"
end