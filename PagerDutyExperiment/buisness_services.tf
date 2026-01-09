
resource "pagerduty_business_service" "bs" {
  for_each    = local.business_services
  name        = each.value.name
  description = each.value.description
}
