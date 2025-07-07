output "public_ip" {
  value = aws_instance.python_node_app.public_ip
}

# output "mongo_uri_debug" {
#   value = var.mongo_uri
# }
