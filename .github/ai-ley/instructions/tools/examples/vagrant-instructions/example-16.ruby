config.vm.box = "centos/7"
config.vm.provision "shell", inline: <<-SHELL
  yum install -y java-1.8.0-openjdk
  yum install -y tomcat
  # Configure specific versions matching production
SHELL