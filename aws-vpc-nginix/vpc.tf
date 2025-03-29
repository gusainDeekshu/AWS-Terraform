#Create A VPC

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    name="my_vpc"
  }
}

#create a private  subnet
resource "aws_subnet" "private_subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    name= "private_subnet"
  }
}

#create a public  subnet
resource "aws_subnet" "public_subnet" {
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    name= "public_subnet"
  }
}

#create a Internet gateway
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    name="my-igw"
  }
}

#create a route  table
resource "aws_route_table" "my-rt" {
  vpc_id = aws_vpc.my_vpc.id
  route  {
    cidr_block="0.0.0.0/0"
    gateway_id=aws_internet_gateway.my-igw.id
  }
}


resource "aws_route_table_association" "public_subnet" {
  route_table_id = aws_route_table.my-rt.id
  subnet_id = aws_subnet.public_subnet.id
}

