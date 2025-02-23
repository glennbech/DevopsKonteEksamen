variable "statuscake_api_token" {}

variable "name_list" {
  type = list(string)
    default = [
        "VG uptime check",
        "XKCD uptime check",
    ]
}

variable "url" {
  type = list(string)
    default = [
        "https://www.vg.no",
        "https://xkcd.com/",
    ]
}

variable "content_matcher" {
    type = list(string)
    default = [
        "Tips oss på",
        "A webcomic of romance,",
    ]
}

