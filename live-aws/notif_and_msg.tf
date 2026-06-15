
resource "aws_sns_topic" "test_topic" {
    name = "test-topic"
}

resource "aws_sqs_queue" "test_queue" {
    name = "test-queue"
    receive_wait_time_seconds = 10
}

resource "aws_sns_topic_subscription" "sqns" {
    topic_arn = aws_sns_topic.test_topic.arn
    protocol = "sqs"
    endpoint = aws_sqs_queue.test_queue.arn
}

resource "aws_sqs_queue_policy" "sqs_pol" {
    queue_url = aws_sqs_queue.test_queue.id

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Effect    = "Allow"
            Principal = "*"
            Action    = "sqs:SendMessage"
            Resource = aws_sqs_queue.test_queue.arn
            Condition = {
                ArnEquals = {
                    "aws:SourceArn" =aws_sns_topic.test_topic.arn
                }
            }
    }]
    })
}