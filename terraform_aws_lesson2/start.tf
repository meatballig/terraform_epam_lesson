provider "aws" {
  access_key = "AKIA4PA7UO554VZXRAPE"
  secret_key = "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"
  region = "us-east-1"
}




module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"
  
  for_each = toset(["one", "two"])

  name = "instance-${each.key}"

  ami                    = "ami-04505e74c0741db8d"
  instance_type          = "t2.micro"
  key_name               = "user1"
  monitoring             = true
  vpc_security_group_ids = ["sg-059eaf36ffb9c709c"]
  subnet_id              = "subnet-025fa271aaeafd7e3"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
