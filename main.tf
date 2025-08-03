provider "aws" {
  region = var.aws_region
}

#🔑 SSH Key Pair
resource "aws_key_pair" "deployer" {
  key_name   = "part2"
  public_key = file("${path.module}/${var.public_key_path}")
}


# resource "aws_instance" "web" {
#      key_name      = var.key_name
# }


# 🔐 Flask Security Group
resource "aws_security_group" "flask_sg" {
  name        = "flask-sg"
  description = "Allow Flask traffic and SSH"

  ingress {
    from_port   = var.flask_port
    to_port     = var.flask_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 🔐 Express Security Group
resource "aws_security_group" "express_sg" {
  name        = "express-sg"
  description = "Allow Express traffic, SSH, and Flask-to-Express communication"

  ingress {
    from_port   = var.express_port
    to_port     = var.express_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = var.flask_port
    to_port         = var.flask_port
    protocol        = "tcp"
    security_groups = [aws_security_group.flask_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 🟦 Flask EC2 Instance
resource "aws_instance" "flask" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  security_groups        = [aws_security_group.flask_sg.name]
  user_data              = file("flask-user-data.sh")

  tags = {
    Name = "Flask-Backend"
  }
}

# 🟧 Express EC2 Instance
resource "aws_instance" "express" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  security_groups        = [aws_security_group.express_sg.name]
  user_data              = file("express-user-data.sh")

  tags = {
    Name = "Express-Frontend"
  }
}