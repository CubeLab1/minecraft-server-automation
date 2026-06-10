provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "minecraft" {
  name = "minecraft-sg"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Minecraft"
    from_port   = 25565
    to_port     = 25565
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

resource "aws_instance" "minecraft" {
  ami                    = "ami-020cba7c55df1f615"
  instance_type          = "t2.micro"
  key_name		 = "Lab9"
  vpc_security_group_ids = [aws_security_group.minecraft.id]

  tags = {
    Name = "minecraft-server"
  }
}

output "public_ip" {
  value = aws_instance.minecraft.public_ip
}
