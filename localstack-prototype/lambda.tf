data "archive_file" "lambdada" {
    type = "zip"
    source_file = "file_gen_test.py"
    output_path = "lambda_function.zip"
}

resource "aws_lambda_function" "file_generator_py" {
    filename = data.archive_file.lambdada.output_path
    function_name = "file-generator-py"

    role = aws_iam_role.prv_inst_app_iam.arn

    handler = "index.handler"
    runtime = "python3.9"

    source_code_hash = data.archive_file.lambdada.output_base64sha256

    /* 
    vpc_config {
      subnet_ids = [aws_subnet.prv_sub.id]
      security_group_ids = [aws_security_group.prv_sg.id]
    }
    */
}