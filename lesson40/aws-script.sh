#!/bin/bash
vpc_name=dum307-vpc
subnet_pub_name="dum307 subnet public"
subnet_priv_name="dum307 subnet private"
gw_name="dum307 internet gateway"
rt_pub_name="route table for public subnet"
sg_name="dum307-ssh-http"
cidr="10.0.0.0/23"
cidr_pub="10.0.0.0/24"
cidr_priv="10.0.1.0/24"
profile="--profile dum307"
key_name=dum307-key-pair
image_id=ami-04e601abe3e1a910f
instance_type=t2.micro
instance_name=Ubuntu_20.04

#create vpc
echo "creating vpc \"${vpc_name}\""
vpc_id=$(aws ec2 create-vpc $profile --cidr-block $cidr --query Vpc.VpcId --output text) > /dev/null 2>/dev/null
aws ec2 create-tags $profile --resources $vpc_id --tags Key=Name,Value="${vpc_name}"

#create public subnet
echo "creating public subnet \"${subnet_pub_name}\""
subnet_pub_id=$(aws ec2 create-subnet $profile --vpc-id $vpc_id --cidr-block $cidr_pub --query Subnet.SubnetId --output text) > /dev/null 2>/dev/null
aws ec2 create-tags $profile --resources $subnet_pub_id --tags Key=Name,Value="${subnet_pub_name}"

#create private subnet
echo "creating private subnet \"${subnet_priv_name}\""
subnet_priv_id=$(aws ec2 create-subnet $profile --vpc-id $vpc_id --cidr-block $cidr_priv --query Subnet.SubnetId --output text) > /dev/null 2>/dev/null
aws ec2 create-tags $profile --resources $subnet_priv_id --tags Key=Name,Value="${subnet_priv_name}"

#create internet gateway
echo "creating internet gateway \"${gw_name}\""
gw_id=$(aws ec2 create-internet-gateway $profile --query InternetGateway.InternetGatewayId --output text) > /dev/null 2>/dev/null
aws ec2 create-tags $profile --resources $gw_id --tags Key=Name,Value="${gw_name}"
aws ec2 attach-internet-gateway $profile --internet-gateway-id $gw_id --vpc-id $vpc_id

#create a route table and default route for public subnet
echo "creating route table for public subnet"
rt_id=$(aws ec2 create-route-table $profile --vpc-id $vpc_id --query RouteTable.RouteTableId --output text)
echo "route table id: \"${rt_id}\""
aws ec2 create-tags $profile --resources $rt_id --tags Key=Name,Value="${rt_pub_name}"
echo "creating default route"
aws ec2 create-route $profile --route-table-id $rt_id --destination-cidr-block 0.0.0.0/0 --gateway-id $gw_id
echo "associating route table with public subnet \"${subnet_pub_name}\""
aws ec2 associate-route-table $profile --route-table-id $rt_id --subnet-id $subnet_pub_id

#create security group
echo "create security group for allow ssh and http \"${sg_name}\""
sg_id=$(aws ec2 create-security-group $profile --group-name $sg_name --description $sg_name --vpc-id $vpc_id --output text)
echo "security group id: \"${sg_id}\""
aws ec2 create-tags $profile --resources $sg_id --tags Key=Name,Value="${sg_name}"
echo "add rule for allow ssh in security group"
aws ec2 authorize-security-group-ingress $profile --group-id $sg_id --protocol tcp --port 22 --cidr 0.0.0.0/0
echo "add rule for allow http in security group"
aws ec2 authorize-security-group-ingress $profile --group-id $sg_id --protocol tcp --port 80 --cidr 0.0.0.0/0

#create key pair
echo "creating key pair \"${key_name}\""
aws ec2 create-key-pair $profile --key-name $key_name --query 'KeyMaterial' --output text > ${key_name}.pem
chmod 400 ${key_name}.pem
echo "path to key: ${PWD}/${key_name}.pem"

#run an instance
echo "run an instance \"${instance_name}\""
instance_id=$(aws ec2 run-instances $profile --image-id $image_id --instance-type $instance_type --count 1 --subnet-id $subnet_pub_id --security-group-ids $sg_id --associate-public-ip-address --key-name ${key_name}  --query Instances[].InstanceId --output text) 
aws ec2 create-tags $profile --resources $instance_id --tags Key=Name,Value="${instance_name}"
IP=$(aws ec2 describe-instances $profile --instance-ids $instance_id --query 'Reservations[].Instances[].PublicIpAddress' --output text)
echo "for connection use command: ssh -i "${key_name}.pem" ubuntu@${IP}"

