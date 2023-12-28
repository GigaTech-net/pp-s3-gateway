resource "template_dir" "task_definition" {
  source_dir      = "${path.module}/templates"
  destination_dir = "${path.module}/rendered"

  vars = {
    execution_role_arn       = var.execution_role_arn
    task_role_arn            = var.task_role_arn
    region                   = var.region
    ecs_service_name         = var.ecs_service_name
    task_definition_name     = var.task_definition_name
    family                   = var.family
    container_name           = var.container_name
    env                      = var.env
    docker_image_url         = ""
    cpu                      = 512
    memory                   = 1024
    docker_container_port    = 8080
  }
}

# Need to look at adding the healthcheck back in to the task definition json. I took it out becuase the containers were failing healthchecks for no apparent reason.
# "healthCheck": {
#   "retries": 3,
#   "command": ["CMD-SHELL", "curl -f http://localhost:8080/health || exit 1"],
#   "timeout": 5,
#   "interval": 5
# },