data "aws_iam_policy_document" "cw_synthetic_canaries_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:GetObject"
    ]
    resources = [
      "${data.aws_s3_bucket.s3_bucket.arn}/*"

    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:GetBucketLocation"
    ]
    resources = [
      data.aws_s3_bucket.s3_bucket.arn

    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:CreateLogGroup"
    ]

    resources = [
      "arn:aws:logs:us-east-1:${var.aws_account}:log-group:/aws/lambda/"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:ListAllMyBuckets",
      "xray:PutTraceSegments"
    ]

    resources = [
      "*"
    ]
  }
  statement {
    actions = [
      "cloudwatch:PutMetricData"
    ]

    resources = [
      "*"
    ]

    condition {
      test     = "StringEquals"
      variable = "cloudwatch:namespace"
      values = [
        "CloudWatchSynthetics"
      ]
    }
  }
  statement {
    effect = "Allow"
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface"
    ]

    resources = [
      "*"
    ]
  }
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "cw_synthetic_canaries_role" {
  name               = "${var.project_name}-${var.environment}-cw-synthetic-canaries-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_policy" "cw_synthetic_canaries_policy" {
  name   = "${var.project_name}-${var.environment}-cw-synthetic-canaries-policy"
  policy = data.aws_iam_policy_document.cw_synthetic_canaries_policy.json
}

resource "aws_iam_role_policy_attachment" "cw_synthetic_canaries_attach_policy" {
  role       = aws_iam_role.cw_synthetic_canaries_role.name
  policy_arn = aws_iam_policy.cw_synthetic_canaries_policy.arn
}
