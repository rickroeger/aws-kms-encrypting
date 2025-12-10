#!/bin/bash

#Get values from terraform
decrypted_file=$(terraform output -raw decrypted_file)
encrypted_file=$(terraform output -raw encrypted_file)
kms_alias=$(terraform output -raw kms_alias)
profile=$(terraform output -raw profile)
region=$(terraform output -raw region)


#conditional check if the decrypted_file exist
#if the decrypted file exist, the file will be encrypted and the decrypted file will be removed
#else, the file will be decrypted and the encrypted file will be removed
if [ -f $decrypted_file ];then
    echo Encrypting File
    aws kms encrypt \
    --key-id "$kms_alias" \
    --plaintext fileb://$decrypted_file \
    --output text \
    --query CiphertextBlob \
    --region $region \
    --profile "$profile" | base64 \
    --decode > $encrypted_file
    [[ $? -eq 0 ]] && rm -f $decrypted_file; echo "Successful Encrypted the file" || echo  Failure Encrypted the file
else
   echo Decrypting File
   aws kms decrypt \
  --key-id "$kms_alias" \
  --ciphertext-blob fileb://$encrypted_file \
  --output text \
  --query Plaintext \
  --region $region\
  --profile "$profile" | base64 \
  --decode > $decrypted_file
  [[ $? -eq 0 ]] && rm -f $encrypted_file; echo "Successful decrypted the file" || echo  Failure decrypted the file
fi