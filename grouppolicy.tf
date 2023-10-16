#rds full
data "aws_iam_policy" "rds_full_access" {
  arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}

#ec2 custome

data "aws_iam_policy_document" "ec2_instance_actions" {
  statement {
    actions = [
      "ec2:StartInstances",
      "ec2:StopInstances",
    ]

    resources = [
      "arn:aws:ec2:*:*:instance/*",
    ]
  }
}

resource "aws_iam_policy" "ec2_instance_actions" {
  name        = "ec2_instance_actions"
  policy      = data.aws_iam_policy_document.ec2_instance_actions.json
}



#Attached AWS managed and custom Policies for the User group
resource "aws_iam_group_policy_attachment" "terraform_group_rds_full_access" {
  policy_arn = data.aws_iam_policy.rds_full_access.arn
  group      = aws_iam_group.terraform-group.name
}

resource "aws_iam_group_policy_attachment" "developers_ec2_instance_actions" {
  policy_arn = aws_iam_policy.ec2_instance_actions.arn
  group      = aws_iam_group.terraform-group.name
}