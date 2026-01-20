resource "aws_instance" "instances" {
  for_each               = var.instances
  ami                    = var.ami
  instance_type          = each.value["instance_type"]
  vpc_security_group_ids = [aws_security_group.ec2[each.key].id]

  tags = {
	Name = "${each.key}-${var.env}"
  }
}

resource "aws_route53_record" "a-records" {
	for_each = var.instances
	zone_id  = var.zone_id
	name     = "${each.key}-${var.env}"
	type     = "A"
	ttl      = 30
	records  = [aws_instance.instances[each.key].private_ip]
}

resource "null_resource" "ansible" {
  depends_on = [aws_instance.instances,aws_route53_record.a-records]
  for_each   = var.instances
  provisioner "remote-exec" {
	connection {
	  type = "ssh"
	  user = "ec2-user"
	  password = "DevOps321"
	  host = aws_instance.instances[each.key].private_ip
	}
	inline = [
	  "sudo dnf install python3.13-pip -y",
	  "sudo pip3.11 install ansible",
	  "ansible-pull -i localhost, -U https://github.com/ckolli66/roboshop-ansible-roles-v1.git main.yaml -e component=${each.key} -e env=${var.env}"
	]
  }
}

