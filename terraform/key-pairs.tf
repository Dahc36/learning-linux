resource "aws_key_pair" "instance_key" {
  key_name   = "terra-key"
  public_key = file(var.KEY_PUBLIC_PATH)
}
