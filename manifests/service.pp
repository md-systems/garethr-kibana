class kibana::service {
  $kibana_home = '/opt/kibana'
  $user = 'root'
  $pid_dir = '/var/run'
  $log_dir = '/var/log'
  $es_port = '9200'
  $es_ip = '127.0.0.1'
  $server_name = '0.0.0.0'
  $smart_index = true
  $app_name = 'kibana'
  $kibana_port = 5601

  file { '/etc/init.d/kibana':
    mode    => 755,
    content => template('kibana/etc/init.d/kibana.erb')
  }

  file { '/etc/init/kibana.conf':
    content => template('kibana/etc/init/kibana.conf.erb')
  }

  service { 'kibana':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }

  File['/etc/init.d/kibana'] -> File['/etc/init/kibana.conf'] ~> Service['kibana']
}
