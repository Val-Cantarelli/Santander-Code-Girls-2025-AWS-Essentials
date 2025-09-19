#!/usr/bin/env bash
# Packages the Python lambdas into zips, uploads them to the specified S3 bucket/prefix
# Usage: ./scripts/package_and_upload.sh <s3-bucket> <s3-prefix>
set -euo pipefail
bucket=${1:-}
prefix=${2:-Module11/}
if [ -z "$bucket" ]; then
  echo "Usage: $0 <s3-bucket> [s3-prefix]"
  exit 1
fi

root_dir=$(cd "$(dirname "$0")/.." && pwd)

# package s3Processor
cd "$root_dir/src/lambdas/s3Processor"
mkdir -p "$root_dir/dist"
# include only python files
zip -r9 "$root_dir/dist/s3Processor.zip" *.py

# ensure target bucket exists (create if missing)
if ! aws s3api head-bucket --bucket "$bucket" 2>/dev/null; then
  echo "Bucket $bucket does not exist. Attempting to create it..."
  if aws s3 mb "s3://$bucket" 2>/dev/null; then
    echo "Created bucket $bucket"
  else
    echo "Could not create bucket $bucket (name may be taken). Generating fallback bucket name..."
    AWS_ACCOUNT=$(aws sts get-caller-identity --query Account --output text || echo unknown)
    AWS_REGION=$(aws configure get region || echo us-east-1)
    TS=$(date +%s)
    fallback="codegirls-artifacts-${AWS_ACCOUNT}-${AWS_REGION}-${TS}"
    echo "Creating fallback bucket: $fallback"
    aws s3 mb "s3://$fallback"
    bucket=$fallback
  fi
fi

aws s3 cp "$root_dir/dist/s3Processor.zip" "s3://$bucket/${prefix}s3Processor.zip"

# package apiGetItem
cd "$root_dir/src/lambdas/apiGetItem"
zip -r9 "$root_dir/dist/apiGetItem.zip" *.py
aws s3 cp "$root_dir/dist/apiGetItem.zip" "s3://$bucket/${prefix}apiGetItem.zip"

echo "Uploaded artifacts to s3://$bucket/$prefix"
