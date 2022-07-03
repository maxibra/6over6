resource "aws_ecr_repository" "ecs_app" {
  for_each = locals.ecs_tasks

  name = "tf-${each.app_name}"

  tags = merge(var.tags, { application = each.value })
}

resource "aws_cloudwatch_log_group" "ecs_app" {
  for_each = locals.ecs_tasks

  name              = "/ecs/${each.value}"
  retention_in_days = 90

  tags = merge(var.tags, { application = each.value })
}

resource "aws_ecs_cluster" "ecs_app" {
  name = "tf-app_cluster"

  capacity_providers = ["FARGATE"]
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "ecs_app" {
  for_each = locals.ecs_tasks

  family                   = "tf-${each.value}"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = each.key.ecs_cpu
  memory                   = each.key.ecs_memory
  container_definitions = templatefile("${path.module}/templates/app.tpl",
    {
      MEMORY_TASK        = each.key.ecs_memory
      CPU_TASK           = each.key.ecs_cpu
      APP_NAME           = each.value,
      APP_REPOSITORY_URL = aws_ecr_repository[each.value].ecs_app.repository_url
      APP_DOCKER_TAG     = each.key.docker_tag,
      APP_LOGS_GROUP     = aws_cloudwatch_log_group[each.value].ecs_app.name,
      AWS_REGION         = "us-east-1",
    }
  )
  execution_role_arn = data.aws_iam_role.app.arn
  task_role_arn      = data.aws_iam_role.app.arn

  tags = merge(var.tags, { application = each.value })
}

resource "aws_ecs_service" "ecs_app" {
  for_each = locals.ecs_tasks

  name                               = "tf-${each.value}"
  cluster                            = aws_ecs_cluster.ecs_app.id
  launch_type                        = "FARGATE"
  platform_version                   = "1.4.0"
  task_definition                    = aws_ecs_task_definition[each.value].ecs_app.arn
  desired_count                      = 1
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200

  network_configuration {
    subnets         = data.aws_subnet_ids.private.ids
    security_groups = [aws_security_group.ecs.id]
  }

  lifecycle {
    ignore_changes = [
      desired_count
    ]
  }

  depends_on = [
    aws_ecs_task_definition.ecs_app,
    aws_security_group.ecs_app,
  ]

  tags = merge(var.tags, { application = each.value })
}
