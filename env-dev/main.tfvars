vpc_cidr_block = "10.10.0.0/16"
env            = "dev"
tags           ={
  company= "HclTech"
  project="expense"
  group="balubadi"
}
public_subnets =["10.10.0.0/24","10.10.1.0/24"]
web_subnets =["10.10.2.0/24","10.10.3.0/24"]
app_subnets =["10.10.4.0/24","10.10.5.0/24"]
db_subnets =["10.10.6.0/24","10.10.7.0/24"]

azs =["us-east-1a","us-east-1b"]
account_id= "955993398443"
default_vpc_id="vpc-0c4258e1140be342c"
default_route_table_id="rtb-076a9674861345f0d"
default_vpc_cidr_id="172.31.0.0/16"

##rds
allocated_storage    = 20
engine               = "mysql"
engine_version       = "5.7.44"
instance_class       = "db.t3.micro"

##app
backend = {
    app_port = 8080
    instance_count =1
    instance_type = "t2.micro"
}
bastion_cidrs = ["172.31.37.78/32"]