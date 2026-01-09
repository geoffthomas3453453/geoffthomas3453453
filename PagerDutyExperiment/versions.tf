
terraform {
  required_version = ">= 1.4.0"
  required_providers {
    pagerduty = {
      source  = "pagerduty/pagerduty"
      version = ">= 3.25.0"
    }
  }
}
