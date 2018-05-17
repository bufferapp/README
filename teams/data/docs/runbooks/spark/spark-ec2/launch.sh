#!/bin/sh
cd spark-ec2
git checkout branch-1.6

export AWS_SECRET_ACCESS_KEY=AWS_SECRET_ACCESS_KEY
export AWS_ACCESS_KEY_ID=AWS_ACCESS_KEY_ID

./spark-ec2 \
  -k buffer \
  -i ~/.ssh/buffer.pem \
  -s 2 \
  -v 1.4.0 \
  -t m3.large \
  --zone=us-east-1c \
  --spot-price=0.13 \
  --additional-security-group=elasticbeanstalk-default \
  --copy-aws-credentials \
  --hadoop-major-version yarn \
  --additional-tags "App:Spark" \
  launch spark
