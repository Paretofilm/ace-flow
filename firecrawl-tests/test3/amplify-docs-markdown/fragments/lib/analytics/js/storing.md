---
title: Installation and Configuration
source: fragments/lib/analytics/js/storing.mdx
---

# Installation and Configuration

The Amazon Kinesis Firehose analytics provider allows you to send analytics data to an [Amazon Kinesis Firehose](https://aws.amazon.com/kinesis/data-firehose) stream for reliably storing data.

## Installation and Configuration

Ensure you have [setup IAM permissions](https://docs.aws.amazon.com/firehose/latest/dev/controlling-access.html) for `firehose:PutRecordBatch`.

Example IAM policy for Amazon Kinesis Firehose:

```javascript
]
}
```

Configure Kinesis Firehose:

```javascript

Amplify.configure(
  }
});
```

## Storing data

You can send a data to a Kinesis Firehose stream with the standard `record` method. Any data is acceptable and `streamName` is required:

```javascript

record(,
  streamName: 'myKinesisStream'
});
```

## Flush events
The recorded events are saved in a buffer and sent to the remote server periodically *(You can tune it with the `flushInterval` option)*. If needed, you have the option to manually clear all the events from the buffer by using the 'flushEvents' API.

```javascript

flushEvents();
```
