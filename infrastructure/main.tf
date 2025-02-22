terraform {
  required_providers {
    statuscake = {
      source = "StatusCakeDev/statuscake"
      version = "2.2.2"
    }
  }
}

variable "statuscake_api_token" {}

provider "statuscake" {
  api_token = var.statuscake_api_token
}

resource "statuscake_uptime_check" "example" {
  check_interval = 300
  confirmation   = 3
  name           = "example-site"
  trigger_rate   = 10

  http_check {
    timeout          = 20
    validate_ssl     = true
    status_codes = [
      "200"
    ]
  }

  monitored_resource {
    address = "https://www.vg.no"
  }
  tags = [
    "production",
  ]
}

output "example_com_uptime_check_id" {
  value = statuscake_uptime_check.example.id
}

resource "statuscake_contact_group" "operations_team" {
  name     = "Operations Team"
  ping_url = "https://www.vg.no"

  email_addresses = [
    "johnsmith@example.com",
    "janesmith@example.com",
  ]
}

output "operations_team_contact_group_id" {
  value = statuscake_contact_group.operations_team.id
}