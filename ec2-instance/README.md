# ec2-instance

The code in the repo is used to create an AWS EC2 instance
and deploy web app to it using ansible.


### 1. Create EC2 instance with terraform
  ```
  cd terraform
  terraform init
  terraform apply
  ```
### 2. Configure server and deploy app
  ```
  cd ansible
  ansible-playbook playbook.yml -i inventory
  ```

### Addidional info

  - You need to have AWS credentials in ~/.aws/credentials for terraform to work.
  - Your AWS role should have all the necessary permissions to create EC2 instances.

### Link to the project details: [https://roadmap.sh/projects/ec2-instance](https://roadmap.sh/projects/ec2-instance).