resource "aws_instance" "webserver_1" {
  depends_on = [
    aws_security_group.webserver_sg
  ]
  ami                    = var.ami_id
  instance_type          = var.instance_type
  iam_instance_profile = "${aws_iam_instance_profile.test_profile1.name}"
  key_name               = "irn-devkey"
  user_data = <<-EOF
		#! /bin/bash
                sudo yum update -y
                sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
		sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
		sudo yum upgrade -y
		sudo amazon-linux-extras install epel  -y
                sudo amazon-linux-extras install java-openjdk11  -y
                sudo yum install java-1.8.0-openjdk-devel -y
                sudo yum install jenkins  -y
                sudo systemctl daemon-reload
                sudo systemctl start jenkins 
  EOF

  subnet_id              =   var.private_subnet_id   
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]
 
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 300
    delete_on_termination = true
  }

  tags = {
    Name = "Jenkins-Python-CICD"
  }
     
}

