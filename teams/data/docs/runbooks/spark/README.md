# Buffer Spark

This runbook contains some scripts, suggested configurations and instructions to launch a Spark cluster.

## Requirements

To be able to run a cluster, you will need:

- [Amazon EC2 Key Pair][ec2-keys] to log into your instances
- [Amazon Access Key ID and Secret Access Key][aws-keys] to use AWS API

[ec2-keys]: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html
[aws-keys]: http://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys

## Launching Spark

We tried two ways to start a Spark Cluster.

- [Flintrock (recommended)](flintrock/README.md) creates a cluster with the
  latest Spark version and makes easy to configure all the details.
- [Spark EC2](spark-ec2/README.md) is configured to run Spark 1.4. This is
  required if you plan to get some data from MongoDB collections using the
  [MongoDB Spark Connector](https://github.com/mongodb/mongo-spark).
