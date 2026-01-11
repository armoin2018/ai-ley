Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "forwarded_port", guest: 5432, host: 5432

  config.vm.provision "shell", inline: <<-SHELL
    # Node.js and npm
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    apt-get install -y nodejs

    # PostgreSQL
    apt-get install -y postgresql postgresql-contrib
    sudo -u postgres createuser -s vagrant

    # Redis
    apt-get install -y redis-server
    systemctl start redis-server
  SHELL
end