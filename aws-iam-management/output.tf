output "users" {
  value = local.user_data[*]
}

output "rolepair" {
  value = local.user_role_pairing
}

output "flaten" {
  value = local.user_role_pairing_flat
}