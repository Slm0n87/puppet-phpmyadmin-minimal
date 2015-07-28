class sist_phpmyadmin inherits sist_vars {

  File {
    owner   => 'root',
    group   => 'root',
    require => Package['phpmyadmin'],
  }

  file { "/var/local/preseed/phpmyadmin.preseed":
    content => template('sist_phpmyadmin/phpmyadmin.preseed.erb'),
    mode    => 600,
    backup  => false,
    require => undef,
  }->
  package { 'phpmyadmin':
    ensure       => $ensure,
    responsefile => "/var/local/preseed/phpmyadmin.preseed",
    require      => Service['mysql'],
  }

  file { '/etc/phpmyadmin/apache.conf':
    source => 'puppet:///modules/sist_phpmyadmin/apache.conf',
    notify  => Service['apache2'],
  }
  file { '/etc/phpmyadmin/htpasswd.setup':
    source => 'puppet:///modules/sist_phpmyadmin/htpasswd.setup',
  }
  file { '/etc/phpmyadmin/config.inc.php':
    source => 'puppet:///modules/sist_phpmyadmin/config.inc.php',
  }

}
