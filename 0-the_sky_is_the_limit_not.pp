# automation script to raise the nginx's worker connection capaciy
exec { 'fix-nginx':
  command => "/bin/bash -c 'sed -i \"s/worker_connections[[:space:]]*[0-9][0-9]*;/worker_connections 4096;/\" /etc/nginx/nginx.conf; if ! grep -q \"^[[:space:]]*worker_rlimit_nofile\" /etc/nginx/nginx.conf; then sed -i \"/^[[:space:]]*worker_processes/a worker_rlimit_nofile 4096;\" /etc/nginx/nginx.conf; fi; nginx -t && service nginx restart'",
  path    => ['/bin', '/usr/bin', '/sbin', '/usr/sbin'],
}
