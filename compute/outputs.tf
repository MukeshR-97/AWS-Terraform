output "public_instance_id" { value = aws_instance.public_ec2.id }
output "public_instance_public_ip" { value = aws_instance.public_ec2.public_ip }
output "private_instance_id" { value = aws_instance.private_ec2.id }
output "private_instance_private_ip" { value = aws_instance.private_ec2.private_ip }
output "public_sg_id" { value = aws_security_group.public_sg.id }
output "private_sg_id" { value = aws_security_group.private_sg.id }
output "private_key_path" { value = local_file.private_key_pem.filename }