provider aws {
  region = "ap-south-1"
}

resource "aws_instance" "my-instance" {
	ami = "ami-0c1a7f89451184c8b"
	instance_type = "t2.micro"
	key_name = "ramcharan"
	user_data = <<-EOF
		#! /bin/bash
                sudo apt-get update  -y
		sudo apt-get install openjdk-8-jdk  -y
		wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
		sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
    /etc/apt/sources.list.d/jenkins.list'
		sudo apt-get update -y
                sudo apt install jenkins -y 
	EOF
	tags = {
		Name = "Terraform"	
		Batch = "5AM"
	}
}
