variable "region" { # tflint-ignore: all
  description = "The AWS region for the app to run in"
  type        = string
  validation {
    condition     = length(var.region) > 0
    error_message = "The region must not be zero length."
  }
}

variable "execution_role_arn" { # tflint-ignore: all
  description = "The AWS execution_role_arn for the app"
  type        = string
  validation {
    condition     = length(var.execution_role_arn) > 0
    error_message = "The execution_role_arn must not be zero length."
  }
}

variable "task_role_arn" { # tflint-ignore: all
  description = "The AWS task_role_arn for the app"
  type        = string
  validation {
    condition     = length(var.task_role_arn) > 0
    error_message = "The task_role_arn must not be zero length."
  }
}

variable "ecs_service_name" { # tflint-ignore: all
  description = "The AWS ecs_service_name for the app"
  type        = string
  validation {
    condition     = length(var.ecs_service_name) > 0
    error_message = "The ecs_service_name must not be zero length."
  }
}

variable "task_definition_name" { # tflint-ignore: all
  description = "The AWS task_definition_name for the app"
  type        = string
  validation {
    condition     = length(var.task_definition_name) > 0
    error_message = "The task_definition_name must not be zero length."
  }
}

variable "family" { # tflint-ignore: all
  description = "The AWS family for the app"
  type        = string
  validation {
    condition     = length(var.family) > 0
    error_message = "The family must not be zero length."
  }
}

variable "container_name" { # tflint-ignore: all
  description = "The AWS container_name for the app"
  type        = string
  validation {
    condition     = length(var.container_name) > 0
    error_message = "The container_name must not be zero length."
  }
}

variable "env" { # tflint-ignore: all
  description = "The env the app is running in, usually dev, test or prod"
  type        = string
  validation {
    condition     = length(var.env) > 0
    error_message = "The env must not be zero length."
  }
}

variable "s3_bucket_name" { # tflint-ignore: all
  description = "The name of the bucket"
  type        = string
  validation {
    condition     = length(var.s3_bucket_name) > 0
    error_message = "The s3_bucket_name must not be zero length."
  }
}

variable "s3_region" { # tflint-ignore: all
  description = "The region of the bucket"
  type        = string
  validation {
    condition     = length(var.s3_region) > 0
    error_message = "The s3_region must not be zero length."
  }
}

variable "s3_server" { # tflint-ignore: all
  description = "The server for s3"
  type        = string
  validation {
    condition     = length(var.s3_server) > 0
    error_message = "The s3_server must not be zero length."
  }
}

variable "s3_server_port" { # tflint-ignore: all
  description = "The server port for s3"
  type        = string
  validation {
    condition     = length(var.s3_server_port) > 0
    error_message = "The s3_server_port must not be zero length."
  }
}

variable "s3_server_proto" { # tflint-ignore: all
  description = "The server protocol for s3"
  type        = string
  validation {
    condition     = length(var.s3_server_proto) > 0
    error_message = "The s3_server_proto must not be zero length."
  }
}

variable "s3_style" { # tflint-ignore: all
  description = "The style for s3"
  type        = string
  validation {
    condition     = length(var.s3_style) > 0
    error_message = "The s3_style must not be zero length."
  }
}

variable "debug" { # tflint-ignore: all
  description = "true to turn debug on, false otherwise"
  type        = string
  validation {
    condition     = length(var.debug) > 0
    error_message = "The debug must not be zero length."
  }
}

variable "aws_sigs_version" { # tflint-ignore: all
  description = "AWS sig version"
  type        = string
  validation {
    condition     = length(var.aws_sigs_version) > 0
    error_message = "The aws_sigs_version must not be zero length."
  }
}

variable "allow_directory_list" { # tflint-ignore: all
  description = "true to allow directory list, false otherwise"
  type        = string
  validation {
    condition     = length(var.allow_directory_list) > 0
    error_message = "The allow_directory_list must not be zero length."
  }
}

variable "provide_index_page" { # tflint-ignore: all
  description = "true to provide index page, false otherwise"
  type        = string
  validation {
    condition     = length(var.provide_index_page) > 0
    error_message = "The provide_index_page must not be zero length."
  }
}

variable "append_slash_for_possible_directory" { # tflint-ignore: all
  description = "true to append slash, false otherwise"
  type        = string
  validation {
    condition     = length(var.append_slash_for_possible_directory) > 0
    error_message = "The append_slash_for_possible_directory must not be zero length."
  }
}

variable "directory_listing_path_prefix" { # tflint-ignore: all
  description = "The path prefix for directory listing"
  type        = string
  validation {
    condition     = length(var.directory_listing_path_prefix) >= 0
    error_message = "The directory_listing_path_prefix must not be zero length."
  }
}

variable "cors_enabled" { # tflint-ignore: all
  description = "true to enable cors, false otherwise"
  type        = string
  validation {
    condition     = length(var.cors_enabled) >= 0
    error_message = "The cors_enabled must not be zero length."
  }
}

variable "aws_access_key_id" { # tflint-ignore: all
  description = "The aws_access_key_id for accessing S3 from NGINX"
  type        = string
  validation {
    condition     = length(var.aws_access_key_id) >= 0
    error_message = "The aws_access_key_id must not be zero length."
  }
}

variable "aws_secret_access_key" { # tflint-ignore: all
  description = "The aws_secret_access_key for accessing S3 from NGINX"
  type        = string
  validation {
    condition     = length(var.aws_secret_access_key) >= 0
    error_message = "The aws_secret_access_key must not be zero length."
  }
}
