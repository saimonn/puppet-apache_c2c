define apache_c2c::userdirinstance(
  $vhost,
  $ensure = present,
) {

  $wwwroot = $apache_c2c::root
  validate_absolute_path($wwwroot)

  $seltype = $::osfamily ? {
    'RedHat' => 'httpd_config_t',
    default  => undef,
  }
  file { "${wwwroot}/${vhost}/conf/userdir.conf":
    ensure  => $ensure,
    source  => 'puppet:///modules/apache_c2c/userdir.conf',
    seltype => $seltype,
    notify  => Exec['apache-graceful'],
  }
}
