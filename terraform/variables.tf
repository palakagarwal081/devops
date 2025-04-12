variable "client_id" {
  description = "Azure Active Directory Application Client ID (App ID)"
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

variable "service_principal_object_id" {
  description = "Object ID of the Service Principal (not App ID)"
  type        = string
}
