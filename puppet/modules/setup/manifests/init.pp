class setup($node_version = "v0.10.26") {
    # Add some default path values
    Exec { path => ['/usr/local/bin','/usr/local/sbin','/usr/bin/','/usr/sbin','/bin','/sbin', "/home/vagrant/nvm/${node_version}/bin"], }

    exec { "apt-update":
        command => "/usr/bin/apt-get update"
    }

    Exec["apt-update"] -> Package <| |>

    # Support packages
    class { support: }

    # Install Node
    class { 'nvm':
        node_version => $node_version,
        require => [Class["support"]]
    }

    # Make sure our code directory has proper permissions
    file { '/home/hackathon-starter':
        ensure => "directory",
        owner  => "vagrant",
        group  => "vagrant"
    }

    # Install packages from package.json
    exec { "npm-install-packages":
      cwd => "/home/vagrant/hackathon-starter",
      command => "npm install",
      require => Exec['install-node'],
    }

    exec { "git submodule update":
      cwd     => "/home/vagrant/hackathon-starter",
      command => "git submodule update --init --recursive",
      require => Class["support"]
    }
}
