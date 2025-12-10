#Create the KMS and the KMS alias for the assymetric decrypt and encrypt
resource "aws_kms_key" "kms" {
  description = "Symmetric KMS"

  tags = {
    Name         = format("%s-%s-%s", lower(var.app), var.environment, var.decrypted_file)
    Environment  = var.environment
    Organization = var.app
    Creator      = "terraform"
  }
}

#create the kms alias. The name must begin with 'alias/' and only contain [0-9A-Za-z_/-]
resource "aws_kms_alias" "kms" {
  name          = format("alias/%s-%s-%s", lower(var.app), var.environment, var.decrypted_name)
  target_key_id = aws_kms_key.kms.key_id
}
