provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "sg_otus_reddit_app" {
  name        = "SG for otus reddit app"
dynamic "ingress" { 
  for_each = [ "22", "9292" ] 
  content {
    from_port        = ingress.value
    to_port          = ingress.value
    protocol         = "tcp" 
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
  egress {
    from_port        = 0 
    to_port          = 0 
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "WebServer_for_otus_reddit_app" {
  ami                    = "ami-04d4b63992fdf183e"
  instance_type          = "t2.micro"
  key_name               = "toolkir"
  vpc_security_group_ids = [aws_security_group.sg_otus_reddit_app.id]
  user_data = filebase64("./startup_scripts/install_components.sh")
}

output "instance_public_ip" {
  value = aws_instance.WebServer_for_otus_reddit_app.public_ip
} 