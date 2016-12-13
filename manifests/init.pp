class dnsmasq (
  $network_ip        = $::dnsmasq::params::network_ip,
  $network_netmask   = $::dnsmasq::params::network_netmask,
  $network_gateway   = $::dnsmasq::params::network_gateway,
  $network_bootproto = $::dnsmasq::params::network_bootproto,
  $network_onboot    = $::dnsmasq::params::network_onboot,
  $network_dns1      = $::dnsmasq::params::network_dns1,
  $network_defroute  = $::dnsmasq::params::network_defroute,
  $network_iface     = $::dnsmasq::params::network_iface,
  $network_domain    = $::dnsmasq::params::network_domain,
) inherits ::dnsmasq::params {

  package { 'dnsmasq':
    ensure => present,
  }

  file { "/etc/dnsmasq.d/${network_domain}":
    ensure  => present,
    content => template("dnsmasq/${network_domain}.erb"),
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

  network::interface { $network_iface:
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
