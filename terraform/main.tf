provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  endpoints {
    ec2 = "http://ip10-0-14-4-d0dgra805akh4glkf930-4566.direct.lab-boris.fr"
    iam = "http://ip10-0-14-4-d0dgra805akh4glkf930-4566.direct.lab-boris.fr"
    sts = "http://ip10-0-14-4-d0dgra805akh4glkf930-4566.direct.lab-boris.fr"
  }
}

# Generate a new pseudo-AMI ID on every apply (using the current timestamp)
resource "random_id" "ami_trigger" {
  byte_length = 2
}
resource "aws_instance" "demo" {
  ami           = "ami-${random_id.ami_trigger.hex}"
  instance_type = "t2.micro"

  tags = {
    Name = "demo"
    ImageID = "ami-${random_id.ami_trigger.hex}"
  }

  lifecycle {
    create_before_destroy = true
  }
}


