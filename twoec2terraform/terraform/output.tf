output "flask_backend_public_ip" {
  value = aws_instance.backend.public_ip
}

output "node_frontend_public_ip" {
  value = aws_instance.frontend.public_ip
}
