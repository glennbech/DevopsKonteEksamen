terraform {
  required_providers {
    statuscake = {
      source  = "StatusCakeDev/statuscake"
      version = "2.2.2"
    }
  }
}

resource "statuscake_uptime_check" "this" {
  check_interval = 300
  confirmation   = 3
  name           = var.name
  trigger_rate   = 10

  contact_groups = [
    var.contact_group_id,
  ]

  http_check {
    enable_cookies    = false
    timeout           = 20
    validate_ssl      = true
    content_matchers  {
      content          = var.content_matcher
      include_headers  = true
      matcher          = "CONTAINS_STRING"
    }
    status_codes = [
      "200"
    ]
  }

  monitored_resource {
    address = var.url
  }

  tags = [
    "production",
  ]
}

output "uptime_check_id" {
  value = statuscake_uptime_check.this.id
}
