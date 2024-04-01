# Install Nginx package
package { 'nginx':
  ensure => installed,
  require => Exec['update'],
}

# Update package repositories
exec { 'update':
  command => 'apt-get -y update',
}

# Configure Nginx with custom HTTP header
file { '/etc/nginx/sites-available/default':
  ensure  => present,
  content => template('nginx/nginx.conf.erb'),
  notify  => Service['nginx'],
  require => Package['nginx'],
}

# Ensure Nginx service is running and restart on configuration changes
service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
  subscribe => File['/etc/nginx/sites-available/default'],
}

