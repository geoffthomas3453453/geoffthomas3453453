
resource "pagerduty_service" "svc" {
  for_each                = local.technical_services
  name                    = each.value.name
  description             = each.value.description
  escalation_policy       = each.value.escalation_policy_id
  auto_resolve_timeout    = each.value.auto_resolve_timeout
  acknowledgement_timeout = each.value.acknowledgement_timeout
}
