subscription_id = "e4f3ef0c-2749-4332-b920-e3b3dd4b7cd2"

location             = "East US"
resource_group_name  = "rg-dev-learn-sdp"

vnet_name            = "vnet-dev-learn-sdp"
vnet_address_space   = ["10.0.0.0/16"]

public_subnet_name   = "public-subnet"
public_subnet_prefix = ["10.0.1.0/24"]

private_subnet_name  = "private-subnet"
private_subnet_prefix = ["10.0.2.0/24"]

pep_subnet_name  = "pep-subnet"
pep_subnet_prefix = ["10.0.3.0/24"]

databricks_name      = "dbw-dev-learn-sdp"
storage_account_name = "sadevlearnsdp"

