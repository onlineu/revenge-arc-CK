resource "aws_sqs_queue" "test_queue" {
    name = "test-queue"
}


resource "aws_sns_topic" "test_topic" {
    name = "test-topic"
}