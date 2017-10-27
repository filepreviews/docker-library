#!/bin/bash

set -e

if [[ "$1" = 'update-metrics' ]]; then
  configKeys=(
    aws_region
    rabbitmq_api_url
    rabbitmq_vhost
    rabbitmq_username
    rabbitmq_password
    rabbitmq_queues
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

  for queue in ${RABBITMQ_QUEUES//,/ }; do
    MESSAGE_COUNT=$(curl -s -u $RABBITMQ_USERNAME:$RABBITMQ_PASSWORD "$RABBITMQ_API_URL/api/queues/$RABBITMQ_VHOST/$queue" | jq -r '.messages')
    TOTAL_COUNT=$(($MESSAGE_COUNT + $TOTAL_COUNT))

    echo "==> Queue[$queue]: $MESSAGE_COUNT"
    aws cloudwatch put-metric-data \
      --region $AWS_REGION \
      --namespace $CLOUDWATCH_NAMESPACE \
      --metric-name $queue \
      --unit "Count" \
      --value $MESSAGE_COUNT
  done

  echo "==> Total: $TOTAL_COUNT"
  aws cloudwatch put-metric-data \
    --region $AWS_REGION \
    --namespace $CLOUDWATCH_NAMESPACE \
    --metric-name "all" \
    --unit "Count" \
    --value $TOTAL_COUNT
else
  exec "$@"
fi
