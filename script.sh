#!/bin/bash

vpc_id=$(aws ec2 create-vpc --cidr-block 10.16.0.0/16 --region us-east-1 --query Vpc.VpcId --output text)

subnet_id=$(aws ec2 create-subnet --vpc-id $vpc_id --cidr-block 10.16.1.0/24 --region us-east-1 --query Subnet.SubnetId --output text)

igw_id=$(aws ec2 create-internet-gateway --region us-east-1 --query InternetGateway.InternetGatewayId --output text)

aws ec2 attach-internet-gateway --vpc-id $vpc_id --internet-gateway-id $igw_id

rtb_id=$(aws ec2 create-route-table --vpc-id $vpc_id --query RouteTable.RouteTableId --output text)

aws ec2 create-route --route-table-id $rtb_id --destination-cidr-block 0.0.0.0/0 --gateway-id $igw_id

aws ec2 associate-route-table --subnet-id $subnet_id --route-table-id $rtb_id

sg_id=$(aws ec2 create-security-group --group-name EC2SecurityGroup --description "Demo Security Group" --vpc-id  $vpc_id --query GroupId --output

aws ec2 authorize-security-group-ingress --group-id $sd_id --protocol tcp --port 22 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id $sg_id --protocol tcp --port 80 --cidr 0.0.0.0/0


