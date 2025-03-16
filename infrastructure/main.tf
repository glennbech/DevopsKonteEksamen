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
  name            = "Ops101"
  email_addresses = var.contact_group_emails
}

module "statuscake_uptime_check_vg" {
  source           = "./modules/statuscake_uptime_check"
  name             = var.name[0]
  url              = var.url[0]
  content_matcher  = var.content_matcher[0]
  contact_group_id = statuscake_contact_group.operations_team.id
}

module "statuscake_uptime_check_xkcd" {
  source           = "./modules/statuscake_uptime_check"
  check_interval   = 300
  name             = var.name[1]
  url              = var.url[1]
  content_matcher  = var.content_matcher[1]
  contact_group_id = statuscake_contact_group.operations_team.id
}

output "operations_team_contact_group_id" {
  value = statuscake_contact_group.operations_team.id
}