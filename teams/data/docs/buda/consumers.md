# Consumers

Anything that reads in data from a stream is said to be a consumer. In this layer you might find a mix of services running in Kubernetes and AWS Lambda functions.

Consumers transform and store the data coming from the streams. New processing services can subscribe to streams and add new transformations without having to rely in the other consumers. Consumers services also take care of saving the data.

## Guidelines

- Use exceptions to handle expected failures. Use dead letter queues to save failed records if appropriate.
- Lambda functions handle a few things automatically like retries or the stream position at any moment. If the consumer is only doing a simple processing consider to run it using Lambda.
- When using AWS Lambda, first process events in batch and then emit the results, this will avoid sending duplicates in case of errors while processing.
- Some records might be read twice since Kinesis doesn't provide _exactly once_ semantics. Aim for idempotent and stateless transformations.
- Consumers should become only very small wrappers for a library code. The library should have tests.

## Resources

- [Best Practices for Working with AWS Lambda Functions](https://docs.aws.amazon.com/lambda/latest/dg/best-practices.html)

## Tools

- [Cerone](https://github.com/bufferapp/cerone): Python consumer that uses Amazon's Kinesis Python Client Library (KCL).
- [Apex](http://apex.run/): tool to build, deploy, and manage AWS Lambda functions with ease.
