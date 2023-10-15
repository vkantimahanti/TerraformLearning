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
   
backend.conf file will specify the resources details where state file needs to be generated. You can place the this file in a folder which is environment specific in order to generate the terraform file.   
https://developer.hashicorp.com/terraform/language/settings/backends/azurerm

### Execute Terraform Commands
1. terraform init - This command will download the terraform plugin to interact with the provider, provider can be azure, aws or gcp.
2. terraform validate - To validate our terraform code syntax. 
3. terraform plan - It will read the terraform files created by us, it will validate and check what all resources to be created, kind of simulation. create the state file.
4. terraform apply - providing an approval to create the required resource infrastructure.
5. terraform destroy - This is to remove the current infrastructure in the provider.

### Modules
If we want to perform a template based deployed, we can follow modularized deployment. A module defines a set of parameters which will be passed as key value pairs to actual deployment. This approach is more helpful to create multiple environments in a very easy manner.
If you observe here, I created a folder Modules and inside that there is a main.tf and variables.tf file, the parameter values for these two files are passed using dev.tf file. This is the most used approach in real time projects.

## Sample terraform script on azure provider.
Below are the steps to create terraform script and execution.  
       1. Create a main.tf file. This file contains all the provider and resource details. check the code in below link.  
                 i. This code will have all the resource details that needs to be created, creating resource group, vnet , subnet, rdp etc.  
                        https://github.com/vkantimahanti/TerraformLearning/blob/main/Modules/main.tf  
       2. Create variable file to declare all the variables whose values vary with each environment.  
                        https://github.com/vkantimahanti/TerraformLearning/blob/main/Modules/variables.tf  
       4. create dev.tf file where all the declared variables are defined, similarly create a int.tf and prod.tf file for each environment. Make sure the source attribute is defined with exact module location.  
                        https://github.com/vkantimahanti/TerraformLearning/blob/main/dev.tf  
              

### Execution Steps
The below steps are executed using any ide, I have used vs code. Open vscode terminal and execute the below below.  
 
#### 1. Login to Azure to perform terraform activity
Execute below commands in the terminal and provider the login, subscription and generate the account list.  
     
       az login  
       az account set -s subscription_name  
       az account list --output table  

#### 2.Terraform commands
Generate current state file of the subscription if any, to make sure nothing impacts with our process, and then execute plan and if no issues then use apply command.  
       
       terraform init -backend-config=".\foldername\filename.conf" -reconfigure  
       terraform plan -var-file .\foldername\terraform.tfvars -out=tfplan  
       terraform apply tfplan  


#### 3. Delete the existing module.
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


