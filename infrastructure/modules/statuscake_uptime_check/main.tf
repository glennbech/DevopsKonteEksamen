terraform {
  required_providers {
    statuscake = {
      source  = "StatusCakeDev/statuscake"
      version = "2.2.2"
    }
  }
}

resource "statuscake_uptime_check" "this" {
  check_interval = var.check_interval
  confirmation   = var.confirmation
  name           = var.name
  trigger_rate   = var.trigger_rate

  contact_groups = [
    var.contact_group_id,
  ]

  http_check {
    enable_cookies    = true
    follow_redirects = true
    timeout           = 30
    validate_ssl      = true
    content_matchers  {
      content          = var.content_matcher
      include_headers  = true
      matcher          = "CONTAINS_STRING"
    }
    status_codes      = var.status_code
  }

  monitored_resource {
    address = var.url
  }

  tags           = var.tags
}

output "uptime_check_id" {
  value = statuscake_uptime_check.this.id
}