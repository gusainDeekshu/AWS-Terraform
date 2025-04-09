terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.92.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.region

}

resource "aws_iam_user" "users" {
  for_each = toset(local.user_data[*].username)
  name     = each.value
}

resource "aws_iam_user_login_profile" "profile" {
  for_each        = aws_iam_user.users
  user            = each.value.name
  password_length = 12
  lifecycle {
    ignore_changes = [
      password_length,
      pgp_key,
      password_reset_required,
    ]
  }
}

#Attaching Policy
resource "aws_iam_policy_attachment" "userPolicy" {
  for_each = {
    for pair in local.user_role_pairing_flat :
    "${pair.username}-${pair.role}" => pair
  }

  name       = "${each.key}-attachment"
  users = [aws_iam_user.users[each.value.username].name]
  policy_arn = "arn:aws:iam::aws:policy/${each.value.role}"
}




locals {
  user_data = yamldecode(file("./users.yaml")).users
  user_role_pairing = [for user in local.user_data :
    [for role in user.roles :
      {
        username = user.username
        role     = role
      }
    ]
  ]
  user_role_pairing_flat = flatten(local.user_role_pairing)
}
