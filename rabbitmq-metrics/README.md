# rabbitmq-metrics

Publish RabbitMQ queue Length to AWS Cloudwatch.

```
$ docker run --rm \
  -e AWS_REGION="us-east-1" \
  -e RABBITMQ_API_URL="http://rabbitmq.ops.filepreviews.io" \
  -e RABBITMQ_VHOST="fp" \
  -e RABBITMQ_USERNAME="" \
  -e RABBITMQ_PASSWORD="" \
  -e RABBITMQ_QUEUES="default,vip" \
  -e CLOUDWATCH_NAMESPACE="ns" \
  filepreviews/rabbitmq-metrics update-metrics
```
