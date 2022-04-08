node 'slave1', 'slave2' {
  $package = ['httpd','php']
  package {$package: ensure => 'installed'}
    service { 'httpd':
    ensure =>running,
    enable => true,
 }
}
