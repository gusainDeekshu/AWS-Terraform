terraform {
  
}

locals {
  value="Hello World"
}

#string list 
variable "string_list" {
  type = list(string)
  default = ["server1","server2","server3","server1"]
}

output "output" {
#   value = upper(local.value)
# value = startswith(local.value,"llo")
# value=split(" ",local.value)
# value = max(1,2,5,7,8,11)
# value = abs(-15)
# value = length(var.string_list)
# value = join(":",var.string_list)
# value = contains(var.string_list,"server2")
value =toset(var.string_list) 

}