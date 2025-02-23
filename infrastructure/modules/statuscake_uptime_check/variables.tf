variable "name" {
  type        = string
  description = "The name of the uptime check"
}

variable "url" {
  type        = string
  description = "The URL to monitor"
}

variable "content_matcher" {
  type        = string
  description = "Content to match in the response body"
}

variable "contact_group_id" {
  type        = string
  description = "The ID of the contact group"
}