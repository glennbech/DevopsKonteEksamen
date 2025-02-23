terraform {
  required_providers {
    statuscake = {
      source = "StatusCakeDev/statuscake"
      version = "2.2.2"
    }
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

resource "statuscake_contact_group" "operations_team" {
  name     = "Operations Team for"
  ping_url = "https://www.vg.no"
  email_addresses = var.contact_group_emails
}

resource "statuscake_uptime_check" "vg" {
  check_interval = 300
  confirmation   = 3
  name           = "VG uptime check"
  trigger_rate   = 10

  contact_groups = [
    statuscake_contact_group.operations_team.id,
  ]

  http_check {
    enable_cookies    = true
    follow_redirects = true
    timeout           = 30
    validate_ssl      = true
    content_matchers  {
      content          = "Tips oss på"
      include_headers  = true
      matcher          = "CONTAINS_STRING"
    }
    status_codes = [
      "200",
      "202",
      "404",
      "405",
    ]
  }

  monitored_resource {
    address = "https://www.vg.no"
  }

  tags = [
    "production",
  ]
}


output "vg_uptime_check_id" {
  value = statuscake_uptime_check.vg.id
}

output "operations_team_contact_group_id" {
  value = statuscake_contact_group.operations_team.id
}
