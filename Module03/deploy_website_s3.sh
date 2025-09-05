#!/bin/bash
# Script to create an S3 bucket, upload website files, and set public read access
# Run: ./deploy_website_s3.sh dio-staticwebsite websiteS3  

set -e

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <bucket-name> <local-directory>"
  exit 1
fi

BUCKET_NAME=$1
LOCAL_DIR=$2

# 1. Create the S3 bucket (region already configured on my cli)
echo "Creating bucket: $BUCKET_NAME"
aws s3 mb s3://$BUCKET_NAME

# 2. Enable public access (remove block public access)
echo "Disabling block public access on bucket"
aws s3api put-public-access-block --bucket $BUCKET_NAME --public-access-block-configuration BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false

# 3. Ajust the policy
cat > /tmp/s3-public-policy.json <<EOL
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::$BUCKET_NAME/*"
    }
  ]
}
EOL
aws s3api put-bucket-policy --bucket $BUCKET_NAME --policy file:///tmp/s3-public-policy.json

# 4. Upload website files and exclude the ds_store
echo "Uploading files"
aws s3 sync $LOCAL_DIR s3://$BUCKET_NAME/ --exclude ".DS_Store" --exclude "*/.DS_Store"

# 5. Enable static website hosting
echo "Enabling static website hosting on bucket"
aws s3 website s3://$BUCKET_NAME/ --index-document index.html --error-document error.html

#  print the endpoint
echo "\nWebsite deployed!"
echo "Access your site at: http://$BUCKET_NAME.s3-website-$(aws configure get region).amazonaws.com/"
