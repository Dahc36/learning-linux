resource "aws_security_group" "terra_sg" {
  name = "terra-SG"

  ingress {
    from_port   = 0
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["191.113.116.208/32"]
  }

  ingress {
    from_port   = 0
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "instance_key" {
  key_name   = "terra-key"
  public_key = file(var.KEY_PUBLIC_PATH)
}

resource "aws_instance" "intro" {
  ami               = var.AMI_MAP[var.REGION]
  instance_type     = "t2.micro"
  availability_zone = var.A_ZONE_MAP[var.REGION]

  key_name               = aws_key_pair.instance_key.key_name
  vpc_security_group_ids = [aws_security_group.terra_sg.id]
  tags = {
    Name = "terraform-instance"
  }

  provisioner "file" {
    source      = "../scripts/web_tooplate_centos.sh"
    destination = "/tmp/web.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/web.sh",
      "sudo /tmp/web.sh",
      "rm /tmp/web.sh"
    ]
  }

  connection {
    private_key = file(var.KEY_PRIVATE_PATH)
    user        = var.USER
    host        = self.public_ip
  }
}
