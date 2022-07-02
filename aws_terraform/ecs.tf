resource "aws_ecr_repository" "ecs_app" {
  name = "tf-${locals.app_name}"

  tags = merge(var.tags, { application = locals.app_name })
}

resource "aws_cloudwatch_log_group" "ecs_app" {
  name              = "/ecs/${locals.app_name}"
  retention_in_days = 90

  tags = merge(var.tags, { application = locals.app_name })
}

resource "aws_ecs_cluster" "ecs_app" {
  name = "tf-${locals.app_name}"

  capacity_providers = ["FARGATE"]
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "ecs_app" {
  family                   = "tf-${locals.app_name}"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = locals.ecs_cpu
  memory                   = locals.ecs_memory
  container_definitions = templatefile("${path.module}/templates/app.tpl",
    {
      MEMORY_TASK        = locals.ecs_memory
      CPU_TASK           = locals.ecs_cpu
      APP_NAME           = locals.app_name,
      APP_REPOSITORY_URL = aws_ecr_repository.ecs_app.repository_url
      APP_DOCKER_TAG     = locals.docker_tag,
      APP_LOGS_GROUP     = aws_cloudwatch_log_group.ecs_app.name,
      AWS_REGION         = "us-east-1",
    }
  )
  execution_role_arn = data.aws_iam_role.app.arn
  task_role_arn      = data.aws_iam_role.app.arn

  tags = merge(var.tags, { application = locals.app_name })
}

resource "aws_ecs_service" "ecs_app" {
  name                               = "tf-${locals.app_name}"
  cluster                            = aws_ecs_cluster.ecs_app.id
  launch_type                        = "FARGATE"
  platform_version                   = "1.4.0"
  task_definition                    = aws_ecs_task_definition.ecs_app.arn
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

  tags = merge(var.tags, { application = locals.app_name })
}
