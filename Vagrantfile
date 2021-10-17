# -*- mode: ruby -*-
# # # vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

server_hostname="master"
server_ip="10.20.90.60"
server_vnc_port=5905

workers = [
  { :hostname => "worker1", :ip => "10.20.90.61", :vnc_port => 5906 },
  { :hostname => "worker2", :ip => "10.20.90.62", :vnc_port => 5907 },
  { :hostname => "worker3", :ip => "10.20.90.63", :vnc_port => 5908 },
  { :hostname => "worker4", :ip => "10.20.90.64", :vnc_port => 5909 },
  { :hostname => "worker5", :ip => "10.20.90.65", :vnc_port => 5910 }
]

$write_server_config=<<SCRIPT
cat <<EOF > /etc/rancher/rke2/config.yaml
token: helloworld
node-external-ip: ${1}
node-ip: ${1}
EOF
SCRIPT

$write_worker_config=<<SCRIPT
cat <<EOF > /etc/rancher/rke2/config.yaml
server: https://${1}:9345
token: helloworld
node-external-ip: ${2}
node-ip: ${2}
EOF
SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.provider :libvirt do |libvirt|
    libvirt.driver = "kvm"
    libvirt.graphics_type = 'vnc'
  end

  config.vm.box = "generic/ubuntu1804"
  config.vm.box_version = "3.4.2"

  config.vm.provision "shell", privileged: true, inline: <<-SHELL
    set -e -x -u
    export DEBIAN_FRONTEND=noninteractive

    apt-get update -y
    apt-get install -y git vim curl build-essential openssh-server
    apt-get install -y jq open-iscsi nfs-common
    
    echo "export CRI_CONFIG_FILE=/var/lib/rancher/rke2/agent/etc/crictl.yaml" >> /root/.bashrc
    echo "export PATH=$PATH:/var/lib/rancher/rke2/bin" >> /root/.bashrc
  SHELL

  # Server node
  config.vm.define "#{server_hostname}" do |node|
    node.vm.hostname = "#{server_hostname}"
    node.vm.network "public_network",
      :dev => "br0",
      :mode => "bridge",
      :type => "bridge",
      :ip => "#{server_ip}"
    node.vm.provider "libvirt" do |v|
      v.cpus = 4
      v.memory = 4096
      v.graphics_ip = '0.0.0.0'
      v.graphics_port = "#{server_vnc_port}"
      v.graphics_passwd = '1234'
    end

    # Install rke-server
    node.vm.provision "shell", privileged: true, inline: "sh -c 'echo export KUBECONFIG=/etc/rancher/rke2/rke2.yaml >> /root/.bashrc'"
    node.vm.provision "shell", privileged: true, inline: "sh -c 'echo export PATH=$PATH:/var/lib/rancher/rke2/bin >> /root/.bashrc'"
    node.vm.provision "shell", privileged: true, inline: "curl -sfL https://get.rke2.io | sh -"
    node.vm.provision "shell", privileged: true, inline: "systemctl enable rke2-server.service"
    node.vm.provision "shell", privileged: true, inline: "mkdir -p /etc/rancher/rke2"
    node.vm.provision "shell", privileged: true, inline: $write_server_config, args: ["#{server_ip}"]
    node.vm.provision "shell", privileged: true, inline: "systemctl start rke2-server.service"
    # Install docker
    node.vm.provision "shell", privileged: true, inline: <<-SHELL
      set -e -x -u
      export DEBIAN_FRONTEND=noninteractive

      apt-get install -y apt-transport-https ca-certificates gnupg lsb-release
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
      echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
      apt-get update -y
      apt-get install -y docker-ce docker-ce-cli containerd.io

      echo "root:vagrant" | chpasswd

      echo "source <(kubectl completion bash)" >> /root/.bashrc
      echo "alias k='kubectl'" >> /root/.bashrc
      echo "complete -F __start_kubectl k" >> /root/.bashrc
      echo "alias kl='kubectl -n longhorn-system'" >> /root/.bashrc
      echo "complete -F __start_kubectl kl" >> /root/.bashrc

      git config --global user.name "Derek Su"
      git config --global user.email derek.su@suse.com
      git config --global core.editor vim
    SHELL
  end

  # Worker nodes
  workers.each do |worker|
    config.vm.define worker[:hostname] do |node|
      hostname = worker[:hostname]
      ip = worker[:ip]
      vnc_port = worker[:vnc_port]

      node.vm.hostname = "#{hostname}"
      node.vm.network "public_network",
        :dev => "br0",
        :mode => "bridge",
        :type => "bridge",
        :ip => "#{ip}"
      node.vm.provider "libvirt" do |v|
        v.cpus = 4
        v.memory = 4096
        v.graphics_ip = '0.0.0.0'
        v.graphics_port = "#{vnc_port}"
        v.graphics_passwd = '1234'
      end
      # Install rke2-agent
      node.vm.provision "shell", privileged: true, inline: "curl -sfL https://get.rke2.io | INSTALL_RKE2_TYPE=\"agent\" sh -"
      node.vm.provision "shell", privileged: true, inline: "systemctl enable rke2-agent.service"
      node.vm.provision "shell", privileged: true, inline: "mkdir -p /etc/rancher/rke2"
      node.vm.provision "shell", privileged: true, inline: $write_worker_config, args: ["#{server_ip}", "#{ip}"]
      node.vm.provision "shell", privileged: true, inline: "systemctl start rke2-agent.service"
    end
  end
end
