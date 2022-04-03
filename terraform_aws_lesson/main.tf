provider "aws" {
  access_key = "AKIA4PA7UO554VZXRAPE"
  secret_key = "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"
  region = "us-east-1"
}


resource "aws_instance" "my_web_server" {
  count = 1
  ami = "ami-04505e74c0741db8d"
  instance_type = "t2.micro"
  
  tags = {
  Name = "My test instance"
  }
  vpc_security_group_ids = [aws_security_group.my_web_server.id]
  user_data = <<EEOOFF
#!/bin/bash
apt-get -y update
apt-get -y install httpd
myip='curl http://169.254.169.254/latest/meta-data/local-ipv4'
echo "<h2>WebServer with IP $myip</h2><br>Build by Terraform!!!" > /var/www/html/index.html
sudo service httpd start
chkconfig httpd on
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



  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    
Name = "allow_https_http"
  }

}
