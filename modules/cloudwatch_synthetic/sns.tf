// NOTE: Chatbot subscription will need to be manually added in UI.
resource "aws_sns_topic" "service_topic" {
  name              = "${var.project_name}-${var.environment}-uptime-notifications"
  kms_master_key_id = "alias/aws/sns"
}
