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