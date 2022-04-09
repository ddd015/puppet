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
    source => 'puppet:///modules/dynamic/httpd.conf',
  file{'/etc/httpd/conf.d/dynamic.conf':
    ensure => file,
    source => 'puppet:///modules/dynamic/dynamic.conf',
    notify => Service['httpd']
  }
  service{'httpd':
    ensure => running
  }
}
