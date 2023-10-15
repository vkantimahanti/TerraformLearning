# TerraformLearning
Learn Terraform Basics and try sample code for better , I would like to share my learnings with simple steps as below.

# Terraform
Terraform is infrastructure as code (IAC), that allows you to build, modify and version Infrastructure in safe and efficient manner. The code looks similar to json.

## Download Terraform from below website.
1. Download the terraform exec file from the website https://developer.hashicorp.com/terraform/downloads as per required operating system.
2. Make sure the path of the terraform file is available in environment variables so that it can be executed from any folder in cmd prompt. we will discuss the execution steps below.

## Terraform Concepts/Key Words
Terraform uses the below key words as part of your code build.
1. Provider - Is the API or Application like Azure, AWS or VMWare where infrastructure need to setup
2. Resources - Resource is a infrastructure block in each provider like vitrual machine in azure
3. variables - Using variables makes our deployment more dynamic. A separate file variables.tf or terraform.vars to store all variable definitions.
4. statefile - After deployment, terraform generates a state file to keep track of current state of the infrastructure, it will use this file to compare the current state of infra with desired state using this file. A file with terraform.tfstate will be created in working directory.
5. Provisioners - ability to run additional steps or tasks when a resource is created or destroyed. This is not a replacement for configuration management tool.

every code block of any provider and resource are available in terraform website, we need to tweet the variable names and select the one which we want to use.
https://registry.terraform.io/providers/hashicorp/azuread/latest/docs
       
   ### Get Missing State file
       terraform import azurerm_resource_group.rg /subscriptions/xxxxxxxxxxxxx/resourcegroup/subscriptionname

       terraform init -backend-config=".\backend.conf" -reconfigure
   
backend.conf file will specific the resources details where state file needs to be generated. You can place the this file in a folder which is environment specific in order to generate the terraform file.   


### Execute Terraform Commands
1. terraform init - This command will download the terraform plugin to interact with the provider, provider can be azure, aws or gcp.
2. terraform validate - To validate our terraform code syntax. 
3. terraform plan - It will read the terraform files created by us, it will validate and check what all resources to be created, kind of simulation. create the state file.
4. terraform apply - providing an approval to create the required resource infrastructure.
5. terraform destroy - This is to remove the current infrastructure in the provider.

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


