provider aws {}

resource "aws_s3_bucket" "this" {
	bucket = "mr_bucket"
	acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "this" {
	bucket = aws_s3_bucket.this.bucket

	index_document {
		suffix = "index.html"
	}
}

resource "aws_s3_object" "files" {
	for_each = fileset("src/", "*")

	bucket = aws_s3_bucket.this.bucket
	key    = each.value
	source = "src/${each.value}"
	etag = filemd5("src/${each.value}")
}
