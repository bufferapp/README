# Streams

We use [Amazon Kinesis Streams][kinesis] to move data between producers and consumers. Kinesis has [standard concepts][kinesis-concepts] as other queueing and pub/sub systems.

- **Stream**: A queue for incoming data to reside in.
- **Shard**: A stream can be composed of one or more shards. One shard can read data at a rate of up to 2 MB/sec and can write up to 1,000 records/sec up to a max of 1 MB/sec.
- **Partition Key**: String that is hashed to determine which shard the record goes to.

[kinesis]: https://docs.aws.amazon.com/streams/latest/dev/introduction.html
[kinesis-concepts]: https://docs.aws.amazon.com/streams/latest/dev/key-concepts.html

## Guidelines

- Each data type should be placed in its own stream. The data is also placed with a well defined schema.
- Name streams as `buda_source_type`. For example, the stream that handles stripe events should be named `buda_stripe_events`.
- Set up CloudWatch alarms for the different metrics taking into account [Amazon Kinesis Streams Limits][limits].

[limits]: https://docs.aws.amazon.com/streams/latest/dev/service-sizes-and-limits.html

## Resources

- [A deep-dive into lessons learned using Amazon Kinesis Streams at scale](https://read.acloud.guru/deep-dive-into-aws-kinesis-at-scale-2e131ffcfa08)
- [Auto-scaling Kinesis streams with AWS Lambda](http://theburningmonk.com/2017/04/auto-scaling-kinesis-streams-with-aws-lambda/)
