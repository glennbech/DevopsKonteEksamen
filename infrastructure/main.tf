terraform {
  required_providers {
    statuscake = {
      source = "StatusCakeDev/statuscake"
      version = "2.2.2"
    }
  }
}

variable "statuscake_api_token" {}

variable "url_content_matcher" {
  type = map(string)
  default = {
    "https://www.vg.no" = "Tips oss på"
    "https://xkcd.com/" = "A webcomic of romance,"
  }
}

variable "contact_group_emails" {
    type = list(string)
    default = [
      "johnsmith@example.com",
      "janesmith@example.com",
      "famini4973@bitflirt.com",
    ]
}

provider "statuscake" {
  api_token = var.statuscake_api_token
}

resource "statuscake_uptime_check" "example" {

  check_interval = 300
  confirmation   = 3
  name           = "https://www.vg.no"
  trigger_rate   = 10

  contact_groups = [
    statuscake_contact_group.operations_team.id,
  ]

  http_check {
    enable_cookies = false
    timeout          = 20
    validate_ssl     = true
    content_matchers  {
      content = "Tips oss på"
      include_headers = true
      matcher = "CONTAINS_STRING"
    }
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

resource "statuscake_uptime_check" "example2" {

  check_interval = 300
  confirmation   = 3
  name           = "https://xkcd.com/"
  trigger_rate   = 10

  contact_groups = [
    statuscake_contact_group.operations_team.id,
  ]

  http_check {
    enable_cookies = false
    timeout          = 20
    validate_ssl     = true
    content_matchers  {
      content = "A webcomic of romance,"
      include_headers = true
      matcher = "CONTAINS_STRING"
    }
    status_codes = [
      "200"
    ]
  }

  monitored_resource {
    address = "https://xkcd.com/"
  }
  tags = [
    "production",
  ]
}

output "example_com_uptime_check_id" {
  value = statuscake_uptime_check.example.id
}

output "xkcd_com_uptime_check_id" {
  value = statuscake_uptime_check.example2.id
}

resource "statuscake_contact_group" "operations_team" {
  name     = "Operations Team for"
  email_addresses = var.contact_group_emails
}

output "operations_team_contact_group_id" {
  value = statuscake_contact_group.operations_team.id
}