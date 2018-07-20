# Replicating MongoDB changes with Change Streams

One of MongoDB 3.6 bew features is [Change Streams][change-streams]. With Change Streams we can access real-time data changes without the complexity and risk of tailing the oplog. This runbook explains a simple and reliable way to get the change streams replicated.

The pipeline explained here uses Kinesis but that could be anything, from files to another database.

[change-streams]: https://docs.mongodb.com/manual/changeStreams/

## Requirements

- [`mongoct`][mongoct]: This tool parses a collection change stream and prints the events to STDOUT
- Docker. Specifically, we'll use [Zendesk's Kinesis Docker image][docker-kinesis]. The image can be used to reliably send data from a file to Kinesis.
- [`rotatelogs`][rotatelogs]: With this CLI tool we'll be able to rotate the logs and avoid making a file bigger and bigger.

[mongoct]: https://github.com/bufferapp/mongoct
[docker-kinesis]: https://github.com/zendesk/docker-amazon-kinesis-agent
[rotatelogs]: https://httpd.apache.org/docs/2.4/programs/rotatelogs.html

## Instructions

First, we need a MongoDB database URI to connect to aswell as the name of the database and collection we want to replicate.
With Python, you can use Pymongo to explore that.

```python
client = pymongo.MongoClient("mongodb+srv://user:pass@host/name")

database = "company"
collection = "posts"

db = client.get_database(database)
posts = db.get_collection(collection)
```

To track changes in `posts`, we'll execute `mongoct company posts $MONGODB_URI` in the terminal. This will print all the changes in that collection. You can test it by adding a new document.

```python
post = {
    "author": "Dan",
    "text": "This is a placeholder",
    "tags": ["fake", "test"],
    "date": "2018-01-01 00:00:00"
}

posts.insert_one(post)
```

After running that, `mongoct` will print a JSON document with the change.

Since we want to capture all the changes we'll be redirecting the STDOUT to a file. To avoid the file growing indifenitely, we'll rotate the output betweena  few files.

```bash
$ mongoct company posts $MONGODB_URI | rotatelogs -n 10 app.log 100K
```

That will create 10 files and start rotating between them as soon as they get to the specified size (100K in our case).

So far we've got the MongoDB collection changes into a few files, now, to send the data to Kinesis, we'll use Zendesk's Kinesis Docker image.

The image requires an `agent.json` file with some details:

```json
{
    "kinesis.endpoint": "",
    "cloudwatch.endpoint": "",
    "flows": [{
        "filePattern": "/tmp/app.log*",
        "kinesisStream": "mongoct-test",
        "partitionKeyOption": "RANDOM"
    }]
}
```

The agent will track all the files that matches the regex `/tmp/app.log*` and send them to the `mongoct-test` Kinesis stream.

Once you've built your image, mount the location where `mongoct` is writting to `/tmp/` and you should see events flowing in!

```bash
$ docker run -v $PWD:/tmp -it --rm --env-file .env davidgasquez/kinesis-test:0.1.0
```

## Summary

1. Running [Zendesk's Kinesis Docker image][docker-kinesis] to keep track of changes in files that matches the pattern.
2. `mongoct company posts | rotatelogs -n 10 app.log 10M` to track and write rotating logs.
