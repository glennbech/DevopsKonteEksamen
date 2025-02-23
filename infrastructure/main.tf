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

module "statuscake_uptime_check_vg" {
  source = "./modules/statuscake_uptime_check"
  name = var.name[0]
  url = var.url[0]
  content_matcher = var.content_matcher[0]
  contact_group_id = statuscake_contact_group.operations_team.id
}

module "statuscake_uptime_check_xkcd" {
  source = "./modules/statuscake_uptime_check"
  name = var.name[1]
  url = var.url[1]
  content_matcher = var.content_matcher[var.url[1]]
  contact_group_id = statuscake_contact_group.operations_team.id
}

output "example_com_uptime_check_id" {
  value = module.statuscake_uptime_check_vg.uptime_check_id
}

output "xkcd_com_uptime_check_id" {
  value = module.statuscake_uptime_check_xkcd.uptime_check_id
}

output "operations_team_contact_group_id" {
  value = statuscake_contact_group.operations_team.id
}