output "website_link" {
  value = "http://${aws_s3_bucket.website.website_endpoint}"
}
# Just to get the website endpoint right in the console 
