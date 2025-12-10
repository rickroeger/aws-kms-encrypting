output "kms_alias" {
  value = aws_kms_alias.kms.name
}

output "decrypted_file" {
  value = var.decrypted_file
}

output "encrypted_file" {
  value = var.encrypted_file
}

output "region" {
  value = var.region
}

output "profile" {
  value = var.profile
}
