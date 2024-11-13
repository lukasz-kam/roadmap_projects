output "instance_public_ip" {
  description = "Public IP address of the ubuntu instance"
  value       = aws_instance.ubuntu_instance.public_ip
}