# Enable MFA for root account (required)
aws iam create-virtual-mfa-device \
    --virtual-mfa-device-name root-account-mfa-device \
    --outfile QRCode.png \
    --bootstrap-method QRCodePNG

# Create IAM role with MFA requirement
aws iam create-role \
    --role-name MFARequiredRole \
    --assume-role-policy-document file://trust-policy-mfa.json