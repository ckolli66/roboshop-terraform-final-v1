resource "aws_security_group" "ec2" {
  for_each = var.instances
  name = "${each.key}-${var.env}"
  description = "${each.key}-${var.env}"

  dynamic "ingress" {
	for_each = each.value["ports"]
	content {
	  from_port   = ingress.value
	  to_port     = ingress.value
	  protocol    = "tcp"
	  cidr_blocks = ["0.0.0.0/0"]
	  description = ingress.key
	}
  }
  egress {
	from_port        = 0
	to_port          = 0
	protocol         = "-1"
	cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
	Name = "${each.key}-${var.env}"
  }
}