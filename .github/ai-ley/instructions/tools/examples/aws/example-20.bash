# Create KMS key for encryption
aws kms create-key \
    --description "Application encryption key" \
    --key-usage ENCRYPT_DECRYPT

# Create key alias
aws kms create-alias \
    --alias-name alias/app-encryption-key \
    --target-key-id 1234abcd-12ab-34cd-56ef-1234567890ab