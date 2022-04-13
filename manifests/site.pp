node 'slave1' {
  include static_conf
  file {'/root/README':
    ensure => absent
    }
}
node 'slave2' {
  include dynamic_conf
  file {'/root/README':
    ensure => absent
    }
}
node 'master' {
include nginx
nginx::resource::server { 'static':
  listen_port => 80,
  proxy => 'http://192.168.56.6:80',
  }
nginx::resource::server { 'dynamic':
  listen_port => 81,
  proxy => 'http://192.168.56.7:80',
  }
}
node 'mcserv' {
  include minecraft
}

class dynamic_conf {
  $package = ['httpd','php']
  package {$package: ensure => 'latest'}
  file {'/var/www/html':
    ensure => directory
    }
  file {'/var/www/html/index.php':
    ensure => file,
    source => 'puppet:///modules/dynamic/index.php'
    }
 # file {'/etc/httpd/conf/httpd.conf':
 #   ensure => file,
 #   source => 'puppet:///modules/dynamic/httpd.conf'
 #  }
  file {'/etc/httpd/conf.d/dynamic.conf':
    ensure => file,
    source => 'puppet:///modules/dynamic/dynamic.conf',
    notify => Service['httpd']
   }
  service {'httpd':
    ensure => running,
    enable => true
   }
  file {'/root/readme':
  ensure => absent
  }
}

class static_conf {
  $package = ['httpd','php']
  package {$package: ensure => 'installed'} 
  file {'/var/www/html':
    ensure => directory
   }
  file {'/var/www/html/index.html':
    ensure => file,
    source => 'puppet:///modules/static/index.html'
   }
#  file {'/etc/httpd/conf/httpd.conf':
#    ensure => file,
#    source => 'puppet:///modules/static/httpd.conf'
#   }
  file {'/etc/httpd/conf.d/static.conf':
    ensure => file,
    source => 'puppet:///modules/static/static.conf',
    notify => Service['httpd']
   }
  service {'httpd':
    ensure => running, 
    enable => true
  }
  file {'/root/readme':
  ensure => absent
  }
}
