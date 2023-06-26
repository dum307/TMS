# Домашнее задание
Написать Bash-скрипт для развертывания в AWS: - VPC - EC2 instance t2.micro - SG для доступа к EC2 через SSH и HTTP

В репозиторий загрузить скрипт, скриншот выполнения и скриншот запущенной ВМ в AWS. После выполнения EC2 instance удалить!

# Запуск скрипта 
```
st-admin@tms:~$ ./aws-script.sh
creating vpc "dum307-vpc"
creating public subnet "dum307 subnet public"
creating private subnet "dum307 subnet private"
creating internet gateway "dum307 internet gateway"
creating route table for public subnet
route table id: "rtb-03b2b8d1cfef685a3"
creating default route
{
    "Return": true
}
associating route table with public subnet "dum307 subnet public"
{
    "AssociationId": "rtbassoc-05f4e15a4250148d2",
    "AssociationState": {
        "State": "associated"
    }
}
create security group for allow ssh and http "dum307-ssh-http"
security group id: "sg-0f1662eda84947480"
add rule for allow ssh in security group
{
    "Return": true,
    "SecurityGroupRules": [
        {
            "SecurityGroupRuleId": "sgr-098c5f27c319109a7",
            "GroupId": "sg-0f1662eda84947480",
            "GroupOwnerId": "959711192947",
            "IsEgress": false,
            "IpProtocol": "tcp",
            "FromPort": 22,
            "ToPort": 22,
            "CidrIpv4": "0.0.0.0/0"
        }
    ]
}
add rule for allow http in security group
{
    "Return": true,
    "SecurityGroupRules": [
        {
            "SecurityGroupRuleId": "sgr-0a7263542714bba28",
            "GroupId": "sg-0f1662eda84947480",
            "GroupOwnerId": "959711192947",
            "IsEgress": false,
            "IpProtocol": "tcp",
            "FromPort": 80,
            "ToPort": 80,
            "CidrIpv4": "0.0.0.0/0"
        }
    ]
}
creating key pair "dum307-key-pair"
path to key: /home/st-admin/dum307-key-pair.pem
run an instance "Ubuntu_20.04"
for connection use command: ssh -i dum307-key-pair.pem ubuntu@3.74.42.5

```

# Скриншоты
### VPC
![vpc](https://s1.hostingkartinok.com/uploads/images/2023/06/43512f2794bb93ecbd0d5d65725f8169.png)

### Subnets
![subnets](https://s1.hostingkartinok.com/uploads/images/2023/06/d8b1adb75ae67f854be032c9efc5af59.png)

### Internet gateway
![gw](https://s1.hostingkartinok.com/uploads/images/2023/06/f0d56a0f41f0c651c58bb27bf67d39e9.png)

### Route tables and default route for public subnet
![rt](https://s1.hostingkartinok.com/uploads/images/2023/06/b3dedf9ae3b9af795ca6d4fbb4dedcec.png)
![default route](https://s1.hostingkartinok.com/uploads/images/2023/06/5c890651641475ec8a3039e126c1c61c.png)

### Security group
![SG](https://s1.hostingkartinok.com/uploads/images/2023/06/56e9407b53ce5524283e2be615c17541.png)
![SG2](https://s1.hostingkartinok.com/uploads/images/2023/06/23cdbba7c6f2fd81d102aa06cffb3bd5.png)

### Key pair
![key](https://s1.hostingkartinok.com/uploads/images/2023/06/614968a3ddd04a045ae335a41df75e43.png)

### Instance
![Instance](https://s1.hostingkartinok.com/uploads/images/2023/06/e3936f1f7fa84420cb8e5273e7b06195.png)