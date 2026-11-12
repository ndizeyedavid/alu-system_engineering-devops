# automation script to raise the nginx's worker connection capaciy
exec { 'raise-nginx-ulimit':
  command => "sed -i 's/ULIMIT=\"-n 15\"/ULIMIT=\"-n 4096\"/' /etc/default/nginx",
  unless  => "grep -q 'ULIMIT=\"-n 4096\"' /etc/default/nginx",
  path    => ['/bin', '/usr/bin'],
}

service { 'nginx':
  ensure    => running,
  subscribe => Exec['raise-nginx-ulimit'],
}
