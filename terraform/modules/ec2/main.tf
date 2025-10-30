data "aws_ami" "selected" {
  most_recent = true
  owners = ["amazon"]
  dynamic "filter" {
    for_each = length(var.ami_filters) > 0 ? var.ami_filters :[
      {name = "name", values = ["amzn2-ami-hvm-*-x86_64-gp2"]}
    ]
    content {
      name = filter.value.name
      values = filter.value.values
    }
  }
}

locals {
  ami = var.ami_id ? var.ami_id : data.aws_ami.selected.id
  user_data = var.user_data_script != "" ? base64decode(var.user_data_script) :null
}

resource "aws_security_group" "web" {
  vpc_id = var.vpc_id
  ingress {
    description = "HTTP from anywhere"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS from anywhere"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_launch_template" "web" {
  image_id = local.ami
  instance_type = var.instance_type
  user_data = local.user_data
  vpc_security_group_ids = [aws_security_group.web.id]
}

resource "aws_autoscaling_group" "name" {
  vpc_zone_identifier = var.subnet_ids
  desired_capacity = var.instance_count
  max_size = var.instance_count + 2
  min_size = var.instance_count
  launch_template {
    id = aws_launch_template.web.id
  }
}