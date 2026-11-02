#dynamic inventories: when aws resources will create by terraform. it will create hosts.ini 
resource "local_file" "ansible_inventory" {
  filename = "${path.module}/inventories/hosts.ini"

  content = <<-EOT
[master]
${aws_instance.my_instance["TWS-Junoon-Master"].public_ip} ansible_user=ubuntu

[workers]
${aws_instance.my_instance["TWS-Junoon-1"].public_ip} ansible_user=ubuntu
${aws_instance.my_instance["TWS-Junoon-2"].public_ip} ansible_user=ec2-user
${aws_instance.my_instance["TWS-Junoon-3"].public_ip} ansible_user=ec2-user

[all:vars]
ansible_ssh_private_key_file=./terra-key-advanced
ansible_python_interpreter=/usr/bin/python3
  EOT
}
