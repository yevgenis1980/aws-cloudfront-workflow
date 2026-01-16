
resource "aws_vpc" "this" {
cidr_block = var.cidr_block
enable_dns_support = true
enable_dns_hostnames = true

tags = {
Name = "${var.project}-vpc"
 }
}

resource "aws_internet_gateway" "this" {
vpc_id = aws_vpc.this.id
}

resource "aws_subnet" "public_a" {
vpc_id = aws_vpc.this.id
cidr_block = "10.0.1.0/24"
map_public_ip_on_launch = true
availability_zone = "us-east-1a"
}

resource "aws_route_table" "public" {
vpc_id = aws_vpc.this.id
}

resource "aws_route" "igw" {
route_table_id = aws_route_table.public.id
destination_cidr_block = "0.0.0.0/0"
gateway_id = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
subnet_id = aws_subnet.public_a.id
route_table_id = aws_route_table.public.id
}
