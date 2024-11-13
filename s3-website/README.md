# s3-static-website

The code in the repo is used to create a static web page
using S3 bucket and Cloudfront.
It uses a S3 bucket for storing terraform state and DynamoDB
for locking the state.


### 1. Create buckets, dynamodb and cloudfront distribution
  ```
  cd terraform/backend_S3
  terraform init
  terraform apply

  cd terraform
  terraform init -backend-config=backend.tfvars
  terraform apply
  ```


### Addidional info

  - You need to have AWS credentials in ~/.aws/credentials for terraform to work.
  - Your AWS role should have all the necessary permissions to create S3 bucket,
    DynamoDB and Cloudfront distribution.

    I manually added permissions to my role on AWS console.
    Remember to change your role name in ```backend_S3/main.tf```:
    ```
    resource "aws_iam_user_group_membership" "user_to_group" {
      user  = "lucas" # role name to change
      groups = [aws_iam_group.state_access_group.name]
    }
    ```

  - When destroying terraform resources remember to also destroy backend bucket and DynamoDB table

### It is S3 variation for the project here: [https://roadmap.sh/projects/ec2-instance](https://roadmap.sh/projects/ec2-instance).