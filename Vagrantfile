# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

Vagrant.require_version '>= 1.5.0'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.hostname = 'le-rsyslog-berkshelf'

  config.omnibus.chef_version = :latest

  config.vm.box = 'hashicorp/precise64'

  config.berkshelf.enabled = true

  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--memory', '1024', '--cpus', '1']
  end

  config.vm.provision :chef_solo do |chef|
    chef.run_list = [
        'recipe[le_rsyslog::default]'
    ]
    chef.json = {
        :le_rsyslog => {
            :datahub => {
                :enabled => false,
                :ip => '127.0.0.1',
                :port => 10000
            }
        }
    }
  end
end
