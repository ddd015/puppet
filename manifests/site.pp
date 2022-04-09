node 'slave1' {
  include static_conf
}
node 'slave2' {
  include dynamic_conf
}


class dynamic_conf {
  $package = ['httpd','php']
  package {$package: ensure => 'installed'}
  file {'/var/www/html':
    ensure => directory
    recurse => true
    }
  file {'/var/www/html/index.php':
    ensure => file,
    source => 'puppet:///modules/dynamic/index.php'
    }
  file {'/etc/httpd/conf/httpd.conf':
    ensure => file,
    source => 'puppet:///modules/dynamic/httpd.conf'
   }
  file {'/etc/httpd/conf.d/dynamic.conf':
    ensure => file,
    source => 'puppet:///modules/dynamic/dynamic.conf',
    notify => Service['httpd']
   }
  service {'httpd':
    ensure => running,
    enable => true
   }
}

class static_conf {
  $package = ['httpd','php']
  package {$package: ensure => 'installed'} 
  file {'/var/www/html':
    ensure => directory
    recurse => true
   }
  file {'/var/www/html/index.html':
    ensure => file,
    source => 'puppet:///modules/static/index.html'
   }
  file {'/etc/httpd/conf/httpd.conf':
    ensure => file,
    source => 'puppet:///modules/static/httpd.conf'
   }
  file {'/etc/httpd/conf.d/static.conf':
    ensure => file,
    source => 'puppet:///modules/static/static.conf'
   }
  service {'httpd':
    ensure => running, 
    enable => true
  }  
}
