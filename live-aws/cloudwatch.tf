resource "aws_cloudwatch_metric_alarm" "lambda_alarm" {
    alarm_name = "lambda-file-gen-error"

    comparison_operator = "GreaterThanThreshold"
    evaluation_periods = 1

    metric_name = "Errors"
    namespace = "AWS/Lambda"
    period = 60
    statistic = "Sum"
    threshold = 0
    alarm_description = "Alerts when Lambda encouters execution crashes"
    treat_missing_data = "notBreaching"
    
    dimensions = {
        FunctionName = aws_lambda_function.file_generator_py.function_name
    }

    alarm_actions = [aws_sns_topic.test_topic.arn]
}