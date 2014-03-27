# Inspired by https://github.com/TryGhost/Ghost-Vagrant/blob/master/manifests/base.pp

$node_version = "v0.10.26"

file { '/etc/motd':
	content => "
***********************************

  Welcome to the
	Hackathon-Starter Virtual Machine!

- OS:      Ubuntu 12.04
- Node:    ${node_version}
- IP:      192.168.33.20

To start the server:
cd hackathon-starter
node app.js

***********************************
\n"
}

class { setup:
	node_version => $node_version
}
