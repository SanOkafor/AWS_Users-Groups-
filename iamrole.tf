resource "aws_iam_role" "terraform-cloudwatchagent-role" {
  name = "terraform-cloudwatchagent-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action    = "sts:AssumeRole"
      }
    ]
  })
}

#attache role policies
resource "aws_iam_role_policy_attachment" "my_role_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy" # Update with your desired policy
  role       = aws_iam_role.terraform-cloudwatchagent-role.name
}