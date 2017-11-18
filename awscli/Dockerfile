FROM alpine:3.6

ENV AWSCLI_VERSION=1.11.178 \
  S3CMD_VERSION=2.0.1 \
  AWS_CFN_BOOTSTRAP_VERSION=1.4-24

RUN apk --no-cache --update add bash curl less groff jq python py-pip && \
  pip install --no-cache-dir --upgrade pip && \
  pip install --no-cache-dir \
    "awscli==$AWSCLI_VERSION" \
    "s3cmd==$S3CMD_VERSION" \
    "https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-$AWS_CFN_BOOTSTRAP_VERSION.tar.gz" && \
  mkdir /root/.aws
