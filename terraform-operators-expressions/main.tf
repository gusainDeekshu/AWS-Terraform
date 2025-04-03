terraform {}

#number list 
variable "number_list" {
  type = list(number)
  default = [ 1,2,3,4,5 ]
}

#object list of persons
variable "persons_list" {
  type = list(object({
    fname = string
    lname = string
  }))
  default = [ {
    fname = "Deekshant"
    lname = "Gusain"
  },{
    fname = "Raju"
    lname = "Rastogi"
  } ]
}


# maplist
variable "maplist" {
  type = map(number)
  default = {
    "zero" = 0
    "one" = 1
    "two" = 2
    "three" = 3
  }
}

#calculations
locals {
  multiply=2*2
  addition=2+2
  eq = 2 !=3

  #double the list
  double=[for num in var.number_list: num*2]

  #odd number only
  odd=[for num in var.number_list: num if num % 2 !=0]

  #firstname
  firstname=[for p in var.persons_list: p.fname]
  
  #work with map 
  mapinfo=[for key,value in var.maplist: value*2]

  double_map={for key,value in var.maplist: key=> value*0 }
}

#output
output "output" {
  value = local.double_map
}