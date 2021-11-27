
data "aws_ami" "nat_ami_amazon2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["NatInstanceBuiltManually-amazon2-arm-v1"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["606500562958"] # Canonical
}

resource "aws_launch_template" "nat" {
  name_prefix   = "nat"
  image_id      = data.aws_ami.nat_ami_amazon2.id
  instance_type = "t4g.micro"
  network_interfaces {
    network_interface_id = aws_network_interface.nat.id
    device_index         = 0
  }
  tags = {
    Name = "Nat Instance Launch Template"
  }
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "Nat Instance"
    }
  }

}

resource "aws_autoscaling_group" "nat" {
  availability_zones = ["${var.aws_region}a"]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1

  launch_template {
    id      = aws_launch_template.nat.id
    version = "$Latest"
  }
}

resource "aws_route" "nat" {
  route_table_id         = var.vpc_private_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = aws_network_interface.nat.id
}

resource "aws_network_interface" "nat" {
  subnet_id         = var.vpc_public_subnet_id
  private_ips       = var.private_ips
  security_groups   = [var.security_group_id]
  source_dest_check = false
}
