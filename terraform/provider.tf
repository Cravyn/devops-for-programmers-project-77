terraform {
    required_providers {
        vkcs = {
            source = "vk-cs/vkcs"
            version = "< 1.0.0"
        }
        datadog = {
            source = "DataDog/datadog"
        }
    }
}

provider "vkcs" {
    # Your user account.
    username = var.login

    # The password of the account
    password = var.pass

    # The tenant token can be taken from the project Settings tab - > API keys.
    # Project ID will be our token.
    project_id = var.pid
    
    # Region name
    region = "RegionOne"
    
    auth_url = "https://infra.mail.ru:35357/v3/" 
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
  api_url = "https://api.us3.datadoghq.com/"
}
