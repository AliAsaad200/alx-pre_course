# File: 2-puppet_custom_http_response_header.pp

# Install Nginx package
package { 'nginx':
  ensure => installed,
}

# Configure custom HTTP response header in Nginx
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
}
