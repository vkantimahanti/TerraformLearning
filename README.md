# TerraformLearning
Learn Terraform Basics and try sample code for better , I would like to share my learnings with simple steps as below.

## Terraform
Terraform is infrastructure as code (IAC), that allows you to build, modify and version Infrastructure in safe and efficient manner. The code looks similar to json.

### Download Terraform from below website.
1. Download the terraform exec file from the website https://developer.hashicorp.com/terraform/downloads as per required operating system.
2. Make sure the path of the terraform file is available in environment variables so that it can be executed from any folder in cmd prompt. we will discuss the execution steps below.

**Note** - Learning azure infrastructure basics helps to build and execute terraform infrastructure code.

## Azure Infrastructure

### Azure Architecture - Secure Data Platform

I would like to share a simple secure architecture that emphasizes on how to create resources on a safe and secured network.  


Let's say am building a secure data platform on azure where databricks extracts and writes data to storage account and all traffic must stay private.

Let's go through some networking concepts of azure as it plays major role in further resource setup.


### Network Concepts 
1. VNet(Virtual Network) - logical network isolation from other VNet's. Let's say if we block complete 2nd floor in a building for a office other are not allowed.

2. Subnet - Divison within VNet, like we are dividing the space and allocating to different teams.

3. Network Security Groups (NSGs): Firewall rules to control traffic, lets say only people with a valid biometric (employees) can enter into first floor. This protects the flow of entry and exit. Similarly NSG control the flow of network traffic to and from azure resource in azure VNet.

4. NAT Gateway: It connects virtual machines in VNet to outbound internet, It's a managed network address translation service that allows private IP's from your VNet to access the traffic using public static IP. In simple, NAT Gateway displays a single IP address even though multiple vm's are connecting to internet. All the vm's are internally tied to NAT.

5. Private Endpoint (PEP): is a private ip inside your vnet as a private entry point to azure Paas services (like Storage, Key Vault, etc.).Example: you create a PEP for blob storage, it assigns a private IP (eg: 10.0.3.4) inside subnet. 

PEP creates an Network Interface and DNS Configuration for secure and private connectivity

6. Network Interface (NIC): The PEP uses a private IP address from VNet. NIC ensures secure traffic between your VNet and Azure Services(SQL, Storage, App Service) avoiding exposure to public internet.

7. DNS(Domain Name System) Configuration: Azure updates the DNS records to ensure Fully Qualified Domain Name (FQDN) of the service resolves to the private end point IP's address within your VNet like private-app.contoso.com. This involves creating a private DNS Zone pointing to the private IP address.
 
5. Route table: Controls the routing of network traffic within virtual network. Enables to define custom routes that overrides azure default route behavior like directing traffic to specific destinations such as gateways or subnets. It gets associated by default to PEP, also can define custom routes for contorlling the traffic. 

### Project Walk Through

1. Create resource Group
2. Create virtual network vnet-learn-hub
3. Create three subnets (public, private and private end point) under vnet-learn-hub 

    i.      subnet-dbw-public -- connecting databricks from any IP

    ii.     subnet-dbw-private -- connecting to other resources within network
    
    iii.    subnet-private-endpoint -- for creating private IP while creating PEP

4. Create storage account with vnet and disable public access
    
    i.      After storage account is created, create private end point and DNS by mapping to same vnet and subnet-private-endpoint

    ii.     you will see a private end point, network interface and private DNS zone.

**Note**: NetworkWatcherRG a resource group will be created automatically which is backend service of Network watcher responsible for network monitor, diagnostics and is fully managed by azure.





## Terraform Concepts 

### Terraform Concepts/Key Words
Terraform uses the below key words as part of your code build.
1. Provider - Is the API or Application like Azure, AWS or VMWare where infrastructure need to setup
2. Resources - Resource is a infrastructure block in each provider like vitrual machine in azure
3. variables - Using variables makes our deployment more dynamic. A separate file variables.tf or terraform.vars to store all variable definitions.
4. statefile - After deployment, terraform generates a state file to keep track of current state of the infrastructure, it will use this file to compare the current state of infra with desired state using this file. A file with terraform.tfstate will be created in working directory.
5. Provisioners - ability to run additional steps or tasks when a resource is created or destroyed. This is not a replacement for configuration management tool.



## Terraform structure (modular) 

terraform/
├── modules/
│   ├── vnet/
│   ├── databricks/
│   ├── storage/
│   ├── nat_gateway/
│   └── route_table/
├── env/
│   ├── dev/
│   │   └── main.tf
│   │   └── terraform.tfvars
│   └── prod/
│       └── main.tf
│       └── terraform.tfvars
└── variables.tf



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

##### Module code Execution
       terraform init
       terraform apply - var-file "dev.tf "


#### 3. Delete the existing module.
       terraform destroy --target=module.module_dev   
       or   
       terraform destroy --auto-approve  


### Data Sources   
"Data Sources" in terraform are used to get information about resources which are not created through terraform, this can be achieved using our Get state file code as well. This is another approach.  


### terraform locals or local variables 
we can create local variables and use it across multiples places.
    
    locals{
        resourgroup_name = "testrsg"
    }

we can use locals.resourcegroup_name at multiple places instead of resource group name


