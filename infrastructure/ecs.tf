resource "template_dir" "task_definition" {
  source_dir      = "${path.module}/templates"
  destination_dir = "${path.module}/rendered"

  vars = {
    execution_role_arn                  = var.execution_role_arn
    task_role_arn                       = var.task_role_arn
    region                              = var.region
    ecs_service_name                    = var.ecs_service_name
    task_definition_name                = var.task_definition_name
    family                              = var.family
    container_name                      = var.container_name
    env                                 = var.env
    aws_access_key_id                   = var.aws_access_key_id
    aws_secret_access_key               = var.aws_secret_access_key
    s3_bucket_name                      = var.s3_bucket_name
    s3_region                           = var.s3_region
    s3_server                           = var.s3_server
    s3_server_port                      = var.s3_server_port
    s3_server_proto                     = var.s3_server_proto
    s3_style                            = var.s3_style
    debug                               = var.debug
    aws_sigs_version                    = var.aws_sigs_version
    allow_directory_list                = var.allow_directory_list
    provide_index_page                  = var.provide_index_page
    append_slash_for_possible_directory = var.append_slash_for_possible_directory
    directory_listing_path_prefix       = var.directory_listing_path_prefix
    docker_image_url                    = ""
    cpu                                 = 512
    memory                              = 1024
    docker_container_port               = 80
  }
}

# Need to look at adding the healthcheck back in to the task definition json. I took it out becuase the containers were failing healthchecks for no apparent reason.
# "healthCheck": {
#   "retries": 3,
#   "command": ["CMD-SHELL", "curl -f http://localhost:80/health || exit 1"],
#   "timeout": 5,
#   "interval": 5
# },