# aws-kms-encrypting
A simple project showing how to encrypt and decrypt files using aws kms

## 1. How to use

Change the file ```terraform.tfvars``` as you needs. Remember to change the profile configuration
```
#main configuration
region      = "us-east-2"
app         = "enc-app"
environment = "qas"
profile     = "mvp"

#KMS config
encrypted_file = "mypasswrd.yaml.enc"
decrypted_file = "mypasswrd.yaml"
decrypted_name = "mypasswrd"
```
Create the enviroment using the terraform
```
terraform apply
```
Create the decrypted_file as your terraform value. You may use the command below in order to create an yaml secret file:
```
kubectl create secret generic mypassword --from-literal=dbpassword=mypasss123 --from-literal=bpassword2=mypasss12 --dry-run=true -o yaml > mypasswrd.yaml
```

## 2.Running the Script
Change the .sh file permissions
```
chmod +x encrypt.sh
```
Execute the script ```./encrypt``` file. It will fill the variable using terraform: 
```
#Get values from terraform
decrypted_file=$(terraform output -raw decrypted_file)
encrypted_file=$(terraform output -raw encrypted_file)
kms_alias=$(terraform output -raw kms_alias)
profile=$(terraform output -raw profile)
region=$(terraform output -raw region)
```

the script is checking if the decrypted_file exist, if it exist, the script will encrypt the file and remove the decrypted file.
```
if [ -f $decrypted_file ];then
```
Else, the script will decrypt the file and removed the encrypted file.
