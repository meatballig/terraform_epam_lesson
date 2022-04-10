


resource "aws_instance" "my_web_server" {
  count = 1
  ami = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  key_name = "terraform2"  
  tags = {
  Name = "My test instance"
  }
  vpc_security_group_ids = [aws_security_group.my_web_server.id]
  user_data = <<EEOOFF
#!/bin/bash
set -x
apt-get -y update
apt-get -y install apache2
myip='curl http://169.254.169.254/latest/meta-data/local-ipv4'
echo "<h2>WebServer with IP $myip</h2><br>Build by Terraform!!!" > /var/www/html/index.html
sudo service apache2 start
chkconfig apache2 on
EEOOFF
}

resource "aws_security_group" "my_web_server" {
  name        = "WebServer Security group"
  description = "First secgroup"

  ingress {
    description      = "in-http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

ingress {
    description      = "in-https"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    
Name = "allow_https_http_ssh"
  }

}
