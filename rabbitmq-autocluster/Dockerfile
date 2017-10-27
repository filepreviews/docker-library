FROM rabbitmq:3.6.12-alpine

ENV AUTOCLUSTER_TYPE=aws \
  AWS_AUTOSCALING=true \
  AUTOCLUSTER_CLEANUP=true \
  CLEANUP_WARN_ONLY=false \
  AWS_DEFAULT_REGION=us-east-1

COPY plugins/ /plugins/
COPY rabbitmq.config /var/lib/rabbitmq/

RUN rabbitmq-plugins enable --offline \
  rabbitmq_management \
  rabbitmq_consistent_hash_exchange \
  rabbitmq_federation \
  rabbitmq_federation_management \
  rabbitmq_mqtt \
  autocluster

EXPOSE 4369 5671 5672 15672 25672
