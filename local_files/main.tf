resource "local_file" "nginx_proxy" {
content = <<-EOF
#!/bin/bash
sudo apt update -y
sudo apt install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
sudo unlink /etc/nginx/sites-enabled/default
sudo sh -c 'echo "server {
  listen 80;
  location / {
    proxy_pass http://${var.internal_lb_dns_name};
  }
}" > /etc/nginx/sites-enabled/proxy.conf'
sudo systemctl restart nginx
EOF
    filename = "nginx_proxy.sh"
}