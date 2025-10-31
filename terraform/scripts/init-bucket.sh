BUCKET_NAME = "terraform-state-2025"
REGION = "ap-southeast-1"
LOCK_TABLE = "terraform-state-locks"

# create s3 bucket
aws s3api create-bucket --bucket $BUCKET_NAME --region $REGION --create-bucket-configuration LocationConstraint=$REGION

# enable versioning
aws s3api put-bucket-versioning --bucket $BUCKET_NAME --versioning-configuration Status=Enabled

# enable server-side encryption
aws s3api put-bucket-encryption --bucket $BUCKET_NAME \
 --server-side-encryption-configuration '{ "Rules": [{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"}}]}'

 # block public access
 aws s3api put-public-access-block --bucket $BUCKET_NAME \
  --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"

# create dynamoDB table for locking
aws dynamodb create-table --table-name $LOCK_TABLE --attribute-definitions AttributeName=LockID,AttributeType=S \ 
--key-schema AttributeName=LockID,KeyType=HASH --billing-mode PAY_PER_REQUEST --region $REGION

echo "Ready"