variable "vpc_ids" {
  type        = string
  description = "Name of environments"
}

variable "aws_region" {
  type        = string
  description = "AWS North Virginia region"
  default     = "us-east-1"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of AZs to be used"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e"]
}

variable "vpc_cidr_blocks" {
  type        = string
  description = "CIDR of VPC"
  default     = "172.10.0.0/16"
}

variable "common_tags" {
  type        = map(string)
  description = "Commonly used tags"
  default = {
    environment = "app_fibonacii"
    managed     = "terraform"
  }
}
