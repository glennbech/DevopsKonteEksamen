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

// Variables with default values
variable "check_interval" {
  type        = number
  description = "The interval between checks in seconds"
  default     = 300
}

variable "confirmation" {
    type        = number
    description = "The number of confirmation checks before an alert is triggered"
    default     = 3
}

variable "trigger_rate" {
  type        = number
  description = "The number of checks that must fail before an alert is triggered"
  default     = 10
}

variable "tags" {
  type        = list(string)
  description = "Tags to apply to the uptime check"
  default     = [
    "production",
  ]
}