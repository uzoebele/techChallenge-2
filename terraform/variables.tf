variable "aws_region" {
  description = "AWS region used for the project"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name used when creating AWS resources"
  type        = string
  default     = "techchallenge2"
}