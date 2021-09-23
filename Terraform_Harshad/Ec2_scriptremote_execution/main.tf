provider aws {
  region = "ap-south-1"
}



data "aws_vpc" "selected" {
  default = true
}

# Get live availability zones list
data "aws_availability_zones" "available" {
  state = "available"
}

# Get the list of subnet ids in selected VPC
data "aws_subnet_ids" "example" {
  vpc_id = data.aws_vpc.selected.id
}


############################## Generating a ssh key in locally #####################
resource "tls_private_key" "webserver_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

######################## copying a private key as webserver.pem ####################

resource "local_file" "private_key" {
  depends_on = [
    tls_private_key.webserver_key,
  ]
  content  = tls_private_key.webserver_key.private_key_pem
  filename = "webserver.pem"
}



# Upload public key to create keypair on AWS
resource "aws_key_pair" "webserver_key" {
  depends_on = [
    tls_private_key.webserver_key,
  ]
  key_name   = "webserver"
  public_key = tls_private_key.webserver_key.public_key_openssh
}


########################## creating a security group ####################
resource "aws_security_group" "webserver_sg" {
  name        = "webserver"
  description = "https, ssh, icmp"
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ping-icmp"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "webserver"
  }
}

############################ creating a instance and installing some services remotely ########################

resource "aws_instance" "webserver_1" {
  depends_on = [
    aws_key_pair.webserver_key,
    aws_security_group.webserver_sg
  ]
  ami                    = "ami-04db49c0fb2215364"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.webserver_key.key_name
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 10
    delete_on_termination = true
  }

  tags = {
    Name = "webserver"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = self.public_ip
    port        = 22
    private_key = tls_private_key.webserver_key.private_key_pem
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd git php -y",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd"
    ]
  }
}

