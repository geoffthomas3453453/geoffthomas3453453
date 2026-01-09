
locals {
  rows = csvdecode(file(var.one_sheet_csv))

  # Business services (deduplicate by name)
  business_services = {
    for r in local.rows :
    trim(r.business_service_name, " ") => {
      name        = trim(r.business_service_name, " ")
      description = try(trim(r.business_service_description, " "), null)
    }
    if length(trim(r.business_service_name, " ")) > 0
  }

  # Technical services (deduplicate by name)
  # NOTE: escalation_policy_id must be present for each technical service.
  technical_services = {
    for r in local.rows :
    trim(r.technical_service_name, " ") => {
      name                    = trim(r.technical_service_name, " ")
      description             = try(trim(r.technical_service_description, " "), null)
      escalation_policy_id    = trim(r.escalation_policy_id, " ")
      auto_resolve_timeout    = try(length(trim(r.auto_resolve_timeout, " ")) > 0 ? tonumber(trim(r.auto_resolve_timeout, " ")) : null, null)
      acknowledgement_timeout = try(length(trim(r.acknowledgement_timeout, " ")) > 0 ? tonumber(trim(r.acknowledgement_timeout, " ")) : null, null)
    }
    if length(trim(r.technical_service_name, " ")) > 0
  }

  # Business -> Technical mappings
  mappings = {
    for r in local.rows :
    "${trim(r.business_service_name, " ")}=>${trim(r.technical_service_name, " ")}" => {
      bs = trim(r.business_service_name, " ")
      ts = trim(r.technical_service_name, " ")
    }
    if length(trim(r.business_service_name, " ")) > 0 && length(trim(r.technical_service_name, " ")) > 0
  }
}
