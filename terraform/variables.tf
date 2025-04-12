# variable "location" {
#   default = "East US"
# }
variable "client_id" {
  description = "Azure Active Directory Application Client ID"
  type        = string
  sensitive   = true
}

variable "client_secret" {
  description = "Azure Active Directory Application Client Secret"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "Azure Active Directory Tenant ID"
  type        = string
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}
