# configuration-management

The code in the repo is used to create an AWS EC2 instance
and deploy web app to it using ansible roles.


### 1. Create EC2 instance with terraform
  ```
  cd terraform
  terraform init
  terraform apply
  ```
### 2. Configure server and deploy app
  ```
  cd ansible

  ansible-playbook prepare_key.yml -i inventory # It is used for changing ssh key permissions to read only, you can also set it manually

  ansible-playbook node_service.yml -i inventory
  or
  ansible-playbook node_service.yml - inventory --tags "app" # every role has its own tag
  ```

### Addidional info

  - You need to have AWS credentials in ~/.aws/credentials for terraform to work.
  - Your AWS role should have all the necessary permissions to create EC2 instances.


### Link to the project details: [https://roadmap.sh/projects/configuration-management](https://roadmap.sh/projects/configuration-management).