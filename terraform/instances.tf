resource "aws_instance" "web_server" {
  ami               = var.AMI_MAP[var.REGION]
  instance_type     = "t2.micro"
  availability_zone = var.A_ZONE_MAP[var.REGION]

  key_name               = aws_key_pair.instance_key.key_name
  vpc_security_group_ids = [aws_security_group.terra_sg.id]
  tags = {
    Name = "terraform-instance"
  }

  connection {
    private_key = file(var.KEY_PRIVATE_PATH)
    user        = var.USER
    host        = self.public_ip
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
}
