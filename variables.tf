variable "environment" {
  type        = string
  description = "Deployment environment. Must be dev or prod."

  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "The environment variable must be either 'dev' or 'prod'."
  }
}

variable "project_name" {
  type        = string
  description = "Name of the project. Used to build resource names."
}

variable "region" {
  type        = string
  description = "AWS region where resources will be deployed."
  default     = "us-east-1"
}

variable "bucket_suffix" {
  type        = string
  description = "Suffix appended to the S3 bucket name, e.g. uploads or assets."
}
