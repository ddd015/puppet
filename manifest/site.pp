node 'slave1', 'slave2' {
  $package = ['httpd','php']
  package {$package: ensure => 'installed'}
}
node slave2 {
  file {'/var/www/dynamic/html':
    ensure => directory
  }
  file {'/var/www/dynamic/html':
    ensure => file,
    source => 'puppet:///modules/dynamic/index.php'
  }
  file{'/etc/httpd/conf/httpd.conf':
    ensure => file,
    source => 'puppet:///modules/dynamic/httpd.conf'
  }
  file{'/etc/httpd/conf.d/dynamic.conf':
    ensure => file,
    source => 'puppet:///modules/dynamic/dynamic.conf',
    notify => Service['httpd']
  }
  service{'httpd':
    ensure => running
  }
}

node slave1 {
  file {'/var/www/static/html':
    ensure => directory
  }
  file {'/var/www/static/html':
    ensure => file,
    source => 'puppet:///modules/static/index.html'
  }
  file{'/etc/httpd/conf/httpd.conf':
    ensure => file,
    source => 'puppet:///modules/static/httpd.conf'
  }
  file{'/etc/httpd/conf.d/static.conf':
    ensure => file,
    source => 'puppet:///modules/static/static.conf',
    notify => Service['httpd']
  }
node 'slave1', 'slave2' {
  service{'httpd':
    ensure => running, 
  enable => true
  }
 }

}
