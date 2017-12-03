#!/bin/bash

set -e

if [[ "$1" = 'aggregate' ]]; then
  configKeys=(
    aws_region
    queue_urls
    cloudwatch_namespace
  )

  for configKey in "${configKeys[@]}"; do
    var="${configKey^^}"
    val="${!var}"
    if [ -z "$val" ]; then
      echo "Missing required setting: $var = $val"
      exit 1
    fi
  done

  TOTAL_COUNT=0

  for QUEUE_URL in ${QUEUE_URLS//,/ }; do
    QUEUE=$(basename $QUEUE_URL)
    MESSAGE_COUNT=$(aws sqs get-queue-attributes --region $AWS_REGION --queue-url $QUEUE_URL --attribute-names ApproximateNumberOfMessages | jq -r '.Attributes.ApproximateNumberOfMessages')
    TOTAL_COUNT=$(($MESSAGE_COUNT + $TOTAL_COUNT))

    echo "==> Queue[$QUEUE]: $MESSAGE_COUNT"
    aws cloudwatch put-metric-data \
      --region $AWS_REGION \
      --namespace $CLOUDWATCH_NAMESPACE \
      --metric-name $QUEUE \
      --unit "Count" \
      --value $MESSAGE_COUNT
  done

  echo "==> Total: $TOTAL_COUNT"
  aws cloudwatch put-metric-data \
    --region $AWS_REGION \
    --namespace $CLOUDWATCH_NAMESPACE \
    --metric-name "total" \
    --unit "Count" \
    --value $TOTAL_COUNT
else
  exec "$@"
fi
