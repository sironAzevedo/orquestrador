# locals {
#   service_definitions = [
#     for idx, service_name in var.services :
#     {
#       name       = service_name
#       port       = 8080 + idx
#       task_def   = "orchestrator-${service_name}-task"
#       container  = "orchestrator-${service_name}-container"
#     }
#   ]
# }