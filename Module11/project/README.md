#  S3 -> Lambda -> DynamoDB
#  API Gateway -> Lambda -> DynamoDB

We will work with a YAML template for CloudFormation and two Lambda functions - one internal and another exposed via API Gateway that will fetch the content saved in the DB and return it to the URL;


## The system is divided into two parts:
   
    - **Part 1:**
        - a file will be sent to S3;
        - S3 will act as a trigger for the `s3Processor` Lambda;
        - the `s3Processor` Lambda reads the content and persists it to DynamoDB;
    - **Part 2:**
        - the `apiGetItem` Lambda, via client request, queries DynamoDB and returns a JSON that will be exposed via API Gateway via GET/items;

## How the deployment was done:

1. via AWS CLI:

```bash
aws cloudformation deploy \
    --template-file Module11/desafio/cloudformation/template.yaml \
    --stack-name codegirls-stack \
    --profile mfa-profile \
    --capabilities CAPABILITY_IAM
```


