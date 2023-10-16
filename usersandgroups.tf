variable "iam_users" {
  type    = list(string)
  default = ["Lola_Adisa", "Astrid_Rowley", "Ridwan_Ishola", "Akshay_Pardeep"]
  ## name (must only contain alphanumeric characters, hyphens, underscores, commas, periods, @ symbols, plus and equals signs)
}

resource "aws_iam_user" "users" {
  count = length(var.iam_users)
  name  = var.iam_users[count.index]
}


resource "aws_iam_group" "terraform-group" {
  name = "terraform-group"
}

resource "aws_iam_group_membership" "users" {
  name  = "aws_iam_group_membership"
  group = aws_iam_group.terraform-group.name
  users = [for user in aws_iam_user.users : user.name]
}

