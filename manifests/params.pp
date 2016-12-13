class dnsmasq::params {
  $network_ip        = '192.168.1.3'
  $network_netmask   = '255.255.255.0'
  $network_gateway   = '192.168.1.1'
  $network_bootproto = 'static'
  $network_onboot    = 'yes'
  $network_dns1      = '192.168.1.1'
  $network_defroute  = true
  $network_iface     = $::facts['networking']['primary']
  $network_domain    = '3031.net'
}
