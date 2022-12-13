# CloudGuard CNAPP Google Organization Onboarding
This Terraform project is intended to be used to onboard an entire Google Tenant in one-shot.     
What it does is configuring, via **Terraform**, an existing CloudGuard CSPM Portal and Google environment that has multiple projects.      
 
## How to start?
You would need to have a CloudGuard tenant, you can create one via *Infinity Portal* by clicking the image below:      
[<img src="https://www.checkpoint.com/wp-content/themes/checkpoint-theme-v2/images/checkpoint-logo.png">](https://portal.checkpoint.com/create-account)

## Get API credentials in your CloudGuard CNAPP Portal
Then you will need to get the API credentials that you will be using with Terraform to onboard the accounts.

![Architectural Design](/zimages/create-cpsm-serviceaccount.jpg)

Remember to copy these two values, you will need to enter them in the *.tfvars* file later on.

## Prerequisite
You would need to have proper permission and authentication in Google. This can be achieved either by specifying the authentication parameters using your service-principal authentication (as described below) or using other means of authenticating as described in [Google Terraform Provider Docs](https://registry.terraform.io/providers/hashicorp/google/latest/docs).

## How to use it
The only thing that you need to do is changing the __*terraform.tfvars*__ file located in this directory.

```hcl
# Set in this file your deployment variables
gcp-region  = "xxxxx-xxxxx-xxxxx-xxxxx"
gcp-project = "xxxxx-xxxxx-xxxxx-xxxxx"
gcp-credentials  = { "type": "service_account", "project_id": "xxxxxxxxxxxxxxxxxxxx", "private_key_id": "xxxxxxxxxxxxxxxxxxxx", "private_key": "-----BEGIN PRIVATE KEY-----\n xxxxxxxxxxxxxxxxxxxx \n-----END PRIVATE KEY-----\n", "client_email": "xxxxxxxxxxxxxxxxxxxx", "client_id": "xxxxxxxxxxxxxxxxxxxx", "auth_uri": "xxxxxxxxxxxxxxxxxxxx", "token_uri": "xxxxxxxxxxxxxxxxxxxx", "auth_provider_x509_cert_url": "xxxxxxxxxxxxxxxxxxxx", "client_x509_cert_url": "xxxxxxxxxxxxxxxxxxxx" }

cspm-key-id         = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
cspm-key-secret     = "xxxxxxxxxxxxxxxxxxxx"
chkp-account-region = "Europe"     // Use either Europe / America or Australia
```
If you want (or need) to further customize other project details, you can change defaults in the different __*name-variables.tf*__ files. Here you will also able to find the descriptions that explains what each variable is used for.