[
  {
    "name": "${APP_NAME}",
    "image": "${APP_REPOSITORY_URL}:${APP_DOCKER_TAG}",
    "networkMode": "awsvpc",
    "memory": ${MEMORY_TASK},
    "cpu": ${CPU_TASK},
    "essential": true,
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${APP_LOGS_GROUP}",
        "awslogs-region": "${AWS_REGION}",
        "awslogs-stream-prefix": "ecs"
      }
    }
  }
]
