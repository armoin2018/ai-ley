# S3 bucket operations
aws s3 mb s3://my-app-bucket-unique-name
aws s3 cp ./build/ s3://my-app-bucket-unique-name --recursive
aws s3 sync ./assets/ s3://my-app-bucket-unique-name/assets/

# Configure bucket for static website hosting
aws s3 website s3://my-app-bucket-unique-name \
    --index-document index.html \
    --error-document error.html