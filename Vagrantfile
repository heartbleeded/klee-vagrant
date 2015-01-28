# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure('2') do |config|
  config.vm.box      = 'ubuntu/precise64'
  config.vm.hostname = 'klee-box'

  config.vm.provision :shell, path: 'bootstrap.sh', keep_color: true, privileged: false
end
