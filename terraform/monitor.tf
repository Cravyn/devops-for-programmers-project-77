resource "datadog_monitor" "devops_ddog" {
  new_group_delay = 60
  no_data_timeframe = 2
  notify_no_data = true
  require_full_window = false
  monitor_thresholds {
    critical = 1
    ok = 1
    warning = 1
  }
  name = "devops_ddog"
  type = "service check"
  query = <<EOT
"datadog.agent.up".over("*").by("host").last(2).count_by_status()
EOT
  message = <<EOT
{{#is_alert}}
{{host.name}} is down
{{/is_alert}}
EOT
}