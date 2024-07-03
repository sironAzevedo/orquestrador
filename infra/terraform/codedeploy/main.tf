resource "aws_codedeploy_app" "ecs" {
  count = length(var.services)
  name  = var.services[count.index].nome
  compute_platform = "ECS"
}

resource "aws_codedeploy_deployment_group" "ecs" {
  count = length(var.services)
  app_name              = aws_codedeploy_app.ecs[count.index].name
  deployment_group_name = "${var.services[count.index].nome}-deployment-group"
  service_role_arn      = var.ecs_task_execution_role_arn

  deployment_style {
    deployment_type = "BLUE_GREEN"
    deployment_option = "WITH_TRAFFIC_CONTROL"
  }

  blue_green_deployment_config {
    terminate_blue_instances_on_deployment_success {
      action = "TERMINATE"
      termination_wait_time_in_minutes = 5
    }
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }
  }

  ecs_service {
    cluster_name = var.aws_ecs_cluster_id
    service_name = var.services[count.index].name
  }

  load_balancer_info {
    target_group_pair_info {
      target_group {
        name = var.target_group_arns[count.index].name
      }

      prod_traffic_route {
        listener_arns = [var.alb_listener_arn]
      }

      test_traffic_route {
        listener_arns = [var.alb_listener_arn]
      }
    }
  }
}