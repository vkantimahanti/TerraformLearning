# TerraformLearning
Learn Terraform Basics and try sample code for better understanding

# Terraform
Terraform is infrastructure as code (IAC). Code is used to setup Infrastructure.

## Terraform Concepts/Key Words
1. Provider - Is the API or Application like Azure, AWS or VMWare where infrastructure need to setup
2. Resources - Resource is a infrastructure block in each provider like vitrual machine in azure
3. variables - Using variables makes our deployment more dynamic. A separate file variables.tf or terraform.vars to store all variable definitions.
4. statefile - After deployment, terraform generates a state file to keep track of current state of the infrastructure, it will use this file to compare the current state of infra with desired state using this file. A file with terraform.tfstate will be created in working directory.
5. Provisioners - ability to run additional steps or tasks when a resource is created or destroyed.


### Execute Terraform Commands
1. terraform INIT - to initialize the provider and connect to terraform.
2. terraform validate - to validate our terraform code syntax. 
3. terraform plan - it will create the state file.
4. terraform apply

### Get Missing State file
terraform import azurerm_resource_group.rg /subscriptions/xxxxxxxxxxxxx/resourcegroup/subscriptionname

### Generate State file in remote state
1. create a storage and container/folder in cloud provider resource group
2. generate a backend config file to get the terraform.state file into cloud location.
https://developer.hashicorp.com/terraform/language/settings/backends/azurerm

### azure process to perform terraform activity
1. az login
2. az account set -s subscription_name
3. az account list --output table

### Terraform commands
terraform init -backend-config=".\foldername\filename.conf" -reconfigure
terraform plan -var-file .\foldername\terraform.tfvars -out=tfplan
terraform apply tfplan

### Modules
If we want to perform a template based deployed, we can follow modularized deployment.

Below is the script for deleting the existing module.
terraform destroy --target=module.module_dev 
or 
terraform destroy --auto-approve


### Data Sources 
"Data Sources" in terraform are used to get information about resources external to terraform, and use them to set up your terraform resources.


### terraform locals or local variables 
we can create local variables and use it across multiples places.
    
    locals{
        resourgroup_name = "testrsg"
    }

we can use locals.resourcegroup_name at multiple places instead of resource group name


