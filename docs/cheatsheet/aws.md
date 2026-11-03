# AWS
## EC2
Creation of VPC:
```bash
aws ec2 create-vpc     --cidr-block 10.0.0.0/27     --tag-specifications 'ResourceType=vpc,Tags=[{Key=Name,Value=labs-w06-vpc},{Key=project,Value=labs},{Key=environment,Value=sandbox},{Key=managed-by,Value=manual},{Key=lab,Value=w06},{Key=expires,Value=2026-10-23}]'
```

Creation of subnet:
```bash
aws ec2 create-subnet --vpc-id <vpc_id> --cidr-block 10.0.0.0/28 --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=labs-w06-public-subnet},{Key=project,Value=labs},{Key=environment,Value=sandbox},{Key=managed-by,Value=manual},{Key=lab,Value=w06}]' --availability-zone-id use1-az1
```

Creation of Internet Gateway
```bash
aws ec2 create-internet-gateway --tag-specifications 'ResourceType=internet-gateway,Tags=[{Key=Name,Value=labs-w06-igw},{Key=project,Value=labs},{Key=environment,Value=sandbox},{Key=managed-by,Value=manual},{Key=lab,Value=w06}]'
```

Creation of RouteTable
```bash
aws ec2 create-route-table --tag-specifications 'ResourceType=route-table,Tags=[{Key=Name,Value=labs-w06-rtb},{Key=project,Value=labs},{Key=environment,Value=sandbox},{Key=managed-by,Value=manual},{Key=lab,Value=w06}]' --vpc-id <vpc id>

# Add a route to the gateway
aws ec2 create-route --route-table-id <route-table-id> --destination-cidr-block 0.0.0.0/0 --gateway-id <gateway-id>
```

Creation of Security Group
```bash
 aws ec2 create-security-group --description "This SG Only allows SSH connections from my pc" --group-name labs-w06-sg-ssh --vpc-id <vpc-id> --tag-specifications "ResourceType=security-group,Tags=[{Key=Name,Value=labs-w06-sg-ssh},{Key=project,Value=labs},{Key=environment,Value=sandbox},{Key=managed-by,Value=manual},{Key=lab,Value=w06}]"

# Create rules for that sg
```

Creation of EC2 Instance
```bash
aws ec2 run-instances --image-id ami-05cf1e9f73fbad2e2 --instance-type t3.micro --security-group-ids 'sg-093f9e7df44ec2213' --subnet-id subnet-0952bda1e735f0782 --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=labs-w06-ec2-i},{Key=project,Value=labs},{Key=environment,Value=sandbox},{Key=managed-by,Value=manual},{Key=lab,Value=w06}]' --key-name "jj-server-laptop"

```
