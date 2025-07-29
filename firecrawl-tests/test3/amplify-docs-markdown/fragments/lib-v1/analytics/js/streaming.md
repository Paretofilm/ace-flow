---
title: Installation and Configuration
source: fragments/lib-v1/analytics/js/streaming.mdx
---

# Installation and Configuration

The Amazon Kinesis analytics provider allows you to send analytics data to an [Amazon Kinesis](https://aws.amazon.com/kinesis) stream for real-time processing.

## Installation and Configuration

Register the _AWSKinesisProvider_ with the Analytics category:

```javascript
Analytics.addPluggable(new AWSKinesisProvider());
```

If you did not use the CLI, ensure you have [setup IAM permissions](https://docs.aws.amazon.com/streams/latest/dev/learning-kinesis-module-one-iam.html) for `PutRecords`.

Example IAM policy for Amazon Kinesis:

```json

  ]
}
```

For more information visit [Amazon Kinesis Developer Documentation](https://docs.aws.amazon.com/streams/latest/dev/learning-kinesis-module-one-iam.html).

Configure Kinesis:

```javascript
// Configure the plugin after adding it to the Analytics module
Analytics.configure(
});
```

## Stream data

You can send a data to a Kinesis stream with the standard `record()` method:

```javascript
Analytics.record(
  ,
    // OPTIONAL
    partitionKey: 'myPartitionKey',
    streamName: 'myKinesisStream'
  },
  'AWSKinesis'
);
```
