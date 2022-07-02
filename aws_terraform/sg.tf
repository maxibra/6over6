resource "aws_security_group" "ecs" {
  name        = "tf-${locals.app_name}"
  description = "allow access from ALB"
  vpc_id      = data.aws_vpc.this.id

  tags = merge(var.tags, { application = locals.app_name })
}
