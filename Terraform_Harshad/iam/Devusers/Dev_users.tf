provider aws {
  region = "ap-south-1"
}

################### creating a group memebership#############################
resource "aws_iam_group_membership" "team" {
  name = "members"

  users = [
    aws_iam_user.user_one.name,
    aws_iam_user.user_two.name,
  ]

  group = aws_iam_group.group.name
}

########################## creating a group Dev#########################################
resource "aws_iam_group" "group" {
  name = "Support"
}

######################## creating a users######################
resource "aws_iam_user" "user_one" {
  name = "harshad123"
}

resource "aws_iam_user" "user_two" {
  name = "harshad156"
}

############################# creating a policy and attaching to group#################################
resource "aws_iam_group_policy" "my_developer_policy" {
  name  = "my_developer_policy"
  group = aws_iam_group.group.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
       {  
        "Effect": "Allow",  
        "Action": [  
          "aws-portal:ViewBilling",  
          "aws-portal:ViewUsage",  
          "autoscaling:Describe*",  
          "cloudformation:DescribeStacks",  
          "cloudformation:DescribeStackEvents",  
          "cloudformation:DescribeStackResources",  
          "cloudformation:GetTemplate",  
          "cloudfront:Get*",  
          "cloudfront:List*",  
          "cloudwatch:Describe*",  
          "cloudwatch:Get*",  
          "cloudwatch:List*",  
          "dynamodb:GetItem",  
          "dynamodb:BatchGetItem",  
          "dynamodb:Query",  
          "dynamodb:Scan",  
          "dynamodb:DescribeTable",  
          "dynamodb:ListTables",  
          "ec2:Describe*",  
          "elasticache:Describe*",  
          "elasticbeanstalk:Check*",  
          "elasticbeanstalk:Describe*",  
          "elasticbeanstalk:List*",  
          "elasticbeanstalk:RequestEnvironmentInfo",  
          "elasticbeanstalk:RetrieveEnvironmentInfo",  
          "elasticloadbalancing:Describe*",  
          "iam:List*",  
          "iam:Get*",  
          "route53:Get*",  
          "route53:List*",  
          "rds:Describe*",  
          "s3:Get*",  
          "s3:List*",  
          "sdb:GetAttributes",  
          "sdb:List*",  
          "sdb:Select*",  
          "ses:Get*",  
          "ses:List*",  
          "sns:Get*",  
          "sns:List*",  
          "sqs:GetQueueAttributes",  
          "sqs:ListQueues",  
          "sqs:ReceiveMessage",  
          "storagegateway:List*",  
          "storagegateway:Describe*"  
  
        ],  
        "Resource": "*"  
      }  
    ]  
  })
}
