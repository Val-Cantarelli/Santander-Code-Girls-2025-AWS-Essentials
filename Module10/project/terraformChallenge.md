## Terraform Challenge Summary — Lambda + API Gateway

1. Directory preparation
	- Lambda function code in `src/handler_function.py` (handler `handler`).
	- Main Terraform file: `main.tf` (generates zip, creates role, lambda and API).
    **Note: I preferred to keep everything in one file since this is a demo.**

2. Authenticated AWS cli;    

3. Initialize Terraform
	- `terraform init` — downloads providers (`aws` and `archive`) and prepares the module.

4. Plan and apply
	- `terraform plan` — reviews the resources that will be created.
	- `terraform apply` — creates resources in AWS (generates `lambda.zip` from `src/` during the process).

5. Verify the endpoint
	- `terraform output -raw api_endpoint` — retrieves the created HTTP endpoint.
	- Quick test: `curl $(terraform output -raw api_endpoint)` — returns the Lambda response.

6. After demonstrating the demo we run:
	- `terraform destroy` — and the resources created by the configuration are deleted from AWS.

---

### Result:

#### Lambda function created in AWS:

![alt text](/Module10/images/AWSLambdaTF.png)

---

#### Returns the message when called on the endpoint:


![alt text](/Module10/images/browserTF.png)

---

### Terraform Flow:

1. The `data "archive_file"` packages the `src/` folder into a `lambda.zip` when Terraform executes plan/apply. This artifact contains the `handler_function.py`.
2. Terraform creates an `aws_iam_role` with minimal policy to allow Lambda to send logs to CloudWatch. (You declare an aws_iam_role in Terraform with minimal permissions - or attach AWSLambdaBasicExecutionRole; the Lambda runtime then writes logs to CloudWatch.)
3. Then the `aws_lambda_function` resource points to the generated `lambda.zip` and uses `handler_function.handler` as entrypoint.
4. The `aws_apigatewayv2_api` (HTTP API) is created and integrated with Lambda via `aws_apigatewayv2_integration` using the function's `invoke_arn`.
5. A `GET /` route is created and the `$default` stage automatically deploys (`auto_deploy = true`).
6. Then the `aws_lambda_permission` allows API Gateway to invoke the Lambda function.

--- 

This challenge was useful to have an experience with Terraform - since we had made a similar solution via CloudFormation using templates and because it brings together common serverless infrastructure components: packaging code, configuring permissions, publishing function and then exposing via API.

With Terraform you declare infrastructure as code - IaC, which facilitates reproducibility and versioning.