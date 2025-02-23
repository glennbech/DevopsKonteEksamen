terraform {
  required_providers {
    statuscake = {
      source = "StatusCakeDev/statuscake"
      version = "2.2.2"
    }
  }
}

provider "statuscake" {
  api_token = var.statuscake_api_token
}

resource "statuscake_contact_group" "operations_team" {
  name     = "Operations Team for"
  email_addresses = var.contact_group_emails
}

resource "statuscake_uptime_check" "vg" {
  check_interval = 300
  confirmation   = 3
  name           = var.name[0]
  trigger_rate   = 10

  contact_groups = [
    statuscake_contact_group.operations_team.id,
  ]

  http_check {
    enable_cookies    = false
    timeout           = 20
    validate_ssl      = true
    content_matchers  {
      content          = var.content_matcher[0]
      include_headers  = true
      matcher          = "CONTAINS_STRING"
    }
    status_codes = [
      "200"
    ]
  }

  monitored_resource {
    address = var.url[0]
  }

  tags = [
    "production",
  ]
}

resource "statuscake_uptime_check" "xkcd" {
  check_interval = 300
  confirmation   = 3
  name           = var.name[1]
  trigger_rate   = 10

  contact_groups = [
    statuscake_contact_group.operations_team.id,
  ]

  http_check {
    enable_cookies    = false
    timeout           = 20
    validate_ssl      = true
    content_matchers  {
      content          = var.content_matcher[1]
      include_headers  = true
      matcher          = "CONTAINS_STRING"
    }
    status_codes = [
      "200"
    ]
  }

  monitored_resource {
    address = var.url[1]
  }

  tags = [
    "production",
  ]
}

output "vg_uptime_check_id" {
  value = statuscake_uptime_check.vg.id
}

output "xkcd_uptime_check_id" {
  value = statuscake_uptime_check.xkcd.id
}

output "operations_team_contact_group_id" {
  value = statuscake_contact_group.operations_team.id
}
