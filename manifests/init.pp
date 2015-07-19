class sist_phpmyadmin inherits sist_vars {

  File {
    owner   => 'root',
    group   => 'root',
  }

  file { "/var/local/preseed/phpmyadmin.preseed":
    content => template('sist_phpmyadmin/phpmyadmin.preseed.erb'),
    mode   => 600,
    backup => false,
  }->
  package { 'phpmyadmin':
    ensure => $ensure,
    responsefile => "/var/local/preseed/phpmyadmin.preseed",
  }

  file { '/etc/phpmyadmin/apache.conf':
    source => 'puppet:///modules/sist_phpmyadmin/apache.conf',
    require => Package['phpmyadmin'],
    notify  => Service['apache2'],
  }
  file { '/etc/phpmyadmin/htpasswd.setup':
    source => 'puppet:///modules/sist_phpmyadmin/htpasswd.setup',
    require => Package['phpmyadmin'],
  }

  #TODO: phpmyadmin-config (setup!)

}
