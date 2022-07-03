locals {
  ecs_tasks = {
    fibonacii = {
        ecs_cpu    = 512
        ecs_memory = 1024
        docker_tag = "latest"
    }
    jenkins = {
        ecs_cpu    = 1024
        ecs_memory = 2048
        docker_tag = "latest"
    }
  }
}
