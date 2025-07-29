---
title: Installation and Configuration
source: fragments/lib-v1/analytics/js/storing.mdx
---

# Installation and Configuration

The Amazon Kinesis Firehose analytics provider allows you to send analytics data to an [Amazon Kinesis Firehose](https://aws.amazon.com/kinesis/data-firehose) stream for reliably storing data.

## Installation and Configuration

Register the _AWSKinesisFirehoseProvider_ with the Analytics category:

```javascript
Analytics.addPluggable(new AWSKinesisFirehoseProvider());
```

Ensure you have [setup IAM permissions](https://docs.aws.amazon.com/firehose/latest/dev/controlling-access.html) for `PutRecordBatch`.

Example IAM policy for Amazon Kinesis Firehose:

```json

  ]
}
```

Configure Kinesis Firehose:

```javascript
// Configure the plugin after adding it to the Analytics module
Analytics.configure(
});
```

## Storing data

You can send a data to a Kinesis Firehose stream with the standard `record` method. Any data is acceptable and `streamName` is required:

```javascript
Analytics.record(
  ,
    streamName: 'myKinesisStream'
  },
  'AWSKinesisFirehose'
);
```
