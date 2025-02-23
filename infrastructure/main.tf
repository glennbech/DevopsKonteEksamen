terraform {
  required_providers {
    statuscake = {
      source = "StatusCakeDev/statuscake"
      version = "2.2.2"
    }
  }
}

variable "statuscake_api_token" {}

variable "url" {
    default = "https://www.vg.no"
}

provider "statuscake" {
  api_token = var.statuscake_api_token
}

resource "statuscake_uptime_check" "example" {
  check_interval = 300
  confirmation   = 3
  name           = "example-site"
  trigger_rate   = 10

  contact_groups = [
    statuscake_contact_group.operations_team.id,
  ]

  http_check {
    enable_cookies = false
    timeout          = 20
    validate_ssl     = true
    status_codes = [
      "200"
    ]
    match_text = "Tips oss på"
  }

  monitored_resource {
    address = var.url
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
  ping_url = var.url

  email_addresses = [
    "johnsmith@example.com",
    "janesmith@example.com",
    "famini4973@bitflirt.com",
  ]
}

output "operations_team_contact_group_id" {
  value = statuscake_contact_group.operations_team.id
}