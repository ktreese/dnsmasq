class dnsmasq (
  $network_ip        = $::dnsmasq::params::network_ip,
  $network_netmask   = $::dnsmasq::params::network_netmask,
  $network_gateway   = $::dnsmasq::params::network_gateway,
  $network_bootproto = $::dnsmasq::params::network_bootproto,
  $network_onboot    = $::dnsmasq::params::network_onboot,
  $network_dns1      = $::dnsmasq::params::network_dns1,
  $network_defroute  = $::dnsmasq::params::network_defroute,
) inherits ::dnsmasq::params {

  package { 'dnsmasq':
    ensure => present,
  }

  file { '/etc/dnsmasq.d/3031.net':
    ensure  => present,
    source  => 'puppet:///modules/dnsmasq/3031.net',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service['dnsmasq'],
    require => Package['dnsmasq'],
  }

  service { 'dnsmasq':
    ensure  => running,
    enable  => true,
    require => Package['dnsmasq'],
  }

  network::interface { $::facts['networking']['primary']:
    ipaddress => $network_ip,
    netmask   => $network_netmask,
    gateway   => $network_gateway,
    bootproto => $network_bootproto,
    onboot    => $network_onboot,
    dns1      => $network_dns1,
    defroute  => $network_defroute,
  }

  Host <<| tag == '3031' |>> ~> Service['dnsmasq']

}
