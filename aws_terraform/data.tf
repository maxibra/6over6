data "aws_iam_role" "app" {
  name = "ecs-task-assume-app-${local.app_name}"
}

data "aws_vpc" "this" {
  filter {
    name   = "tag:account"
    values = ["tf-${local.app_name}"]
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.this.id
  filter {
    name   = "tag:Tier"
    values = ["Public"]
  }
}

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.this.id
  filter {
    name   = "tag:Tier"
    values = ["Private"]
  }
}
