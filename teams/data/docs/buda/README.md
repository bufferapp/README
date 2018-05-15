# Buffer Unified Data Architecture

Documentation, guidelines and resources related to the Buffer Unified Data Architecture, also known as BUDA. A unified data architecture mean that all the different data paths will share patterns between them. This architecture relies on event logs to synchronize the different steps of the data pipeline.

## Table of Contents

- [Principles](#principles)
- [Overview](#overview)
    - [Producers](producers.md)
    - [Streams](streams.md)
    - [Consumers](consumers.md)
- [Naming Convention](naming-conventions.md)
- [Resources](#resources)

## Principles

- **Simplicity**: The different steps are easy to understand, modify, and test.
- **Reliability**: All the errors in the pipeline can be recovered.
- **Modularity**: Each step can be iterated independently.
- **Consistency**: We follow the same conventions and design patterns in all pipelines.
- **Efficiency**: Data flows as real time as possible, and we can scale out to handle load as needed.
- **Flexibility**: We have the ability to transform, model and annotate data easily to enable power analysis and application of data.

## Overview

Buda, or Buffer Unified Data Architecture, consolidates the architecture of our data flows. The general pattern of this architecture involves different steps; producing the data, storing the data in a log, and consuming the data.

![Buffer Unified Data Architecture](https://d2mxuefqeaa7sj.cloudfront.net/s_3EAB683638C13FFF3154D0EC56FE49942EA7C476EC134D1DF4BCFBC3031D8D94_1498724503554_Buffer+Unified+Data+Architecture.png)

### :pencil: [**Producers**](producers.md)

Different services take care of gathering events from specific sources (Mongo, Stripe, Buffer) and sending them to a Kinesis Stream. The responsibility of integrating with the pipeline and providing a clean, well-structured data feed lies with the producers.

### :books: [**Streams**](streams.md)

Kinesis Streams act as the unified log layer where the data is stored for a certain period of time. Each stream contains similar events.

### :book: [**Consumers**](consumers.md)

Services read data from the streams and apply transformations. All the data transformations should be included here. New processing services can subscribe to streams and add new transformations without having to rely in the other consumers. Consumers services take care of saving the data.

### :house: **Data Warehouse**

Data is in the desired state and placed in a Data Warehouse, ready to be used!

## Structure

Each pipeline is self-contained in a repository. This repository should contain all the necessary code to run, understand, and modify the entire pipeline.

## Resources

- Video: [The Many Meanings of Event-Driven Architecture](https://youtu.be/STKCRSUsyP0) by Martin Fowler
- Article: [Importance of the Log](https://engineering.linkedin.com/distributed-systems/log-what-every-software-engineer-should-know-about-real-time-datas-unifying)
- Book: [Designing Data-Intensive Applications](http://dataintensive.net/)

## Roadmap

- Handle Schema Evolution
- Hability to replay events
- Continuous Integration and Deployment
- Standard format for data at rest
- Compress data in streams
- Kinesis Shards Autoscaling
