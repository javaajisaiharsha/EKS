provider aws {
  region = "ap-south-1"
}







resource "aws_iam_user" "example" {
  name          = "example"
  path          = "/"
  force_destroy = true
}

resource "aws_iam_user_login_profile" "example" {
  user    = aws_iam_user.example.name
#  pgp_key = "keybase:harshad154"   ##################333 how to generate a keybase pgp key #############################
  pgp_key   =  "${base64encode(file("/home/Desktop/cloudformation/newcloudformation/modules/pwc/iam/iam_userpass/avinash.pgp"))}"
#  pgp_key = file("avinash.pgp")
  password_length  = 10
  password_reset_required = true
}

resource "aws_iam_account_password_policy" "iamacpp" {
  allow_users_to_change_password = true
  hard_expiry                    = false
  max_password_age               = 90
  minimum_password_length        = 10
  password_reuse_prevention      = 1
  require_lowercase_characters   = true
  require_uppercase_characters   = true
  require_numbers                = true
  require_symbols                = true
}




output "password" {
  value = aws_iam_user_login_profile.example.encrypted_password
}


