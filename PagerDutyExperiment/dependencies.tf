
# Create Service Graph dependencies: Business depends on Technical
resource "pagerduty_service_dependency" "bs_depends_on_ts" {
  for_each = local.mappings

  dependency {
    dependent_service {
      id   = pagerduty_business_service.bs[each.value.bs].id
      type = "business_service"
    }
    supporting_service {
      id   = pagerduty_service.svc[each.value.ts].id
      type = "service"
    }
  }
}
