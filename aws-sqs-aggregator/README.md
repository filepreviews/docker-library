# aws-sqs-aggregator

Aggregates SQS queue `ApproximateNumberOfMessages` metrics to AWS Cloudwatch.

```
$ docker run --rm \
  -e AWS_REGION="us-east-1" \
  -e QUEUE_URLS="https://sqs.us-east-1.amazonaws.com/80398EXAMPLE/default,https://sqs.us-east-1.amazonaws.com/80398EXAMPLE/vip" \
  -e CLOUDWATCH_NAMESPACE="ns" \
  filepreviews/aws-sqs-aggregator aggregate
```
