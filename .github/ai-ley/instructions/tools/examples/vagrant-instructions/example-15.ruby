(1..3).each do |i|
  config.vm.define "service#{i}" do |node|
    node.vm.box = "ubuntu/focal64"
    node.vm.network "private_network", ip: "192.168.56.#{10+i}"
    node.vm.provision "shell", path: "scripts/service#{i}.sh"
  end
end