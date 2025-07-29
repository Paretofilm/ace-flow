---
title: Installation and Configuration
topics: ['Analytics']
primary_topic: Analytics
source: fragments/lib/analytics/js/streaming.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, analytics]
---


## 🧭 Navigation
**Topics**: [[Analytics/]]
**Primary**: [[Analytics/]]

---


# Installation and Configuration

The Amazon Kinesis analytics provider allows you to send analytics data to an [Amazon Kinesis](https://aws.amazon.com/kinesis) stream for real-time processing.

## Installation and Configuration

If you did not use the CLI, ensure you have [setup IAM permissions](https://docs.aws.amazon.com/streams/latest/dev/learning-kinesis-module-one-iam.html) for `kinesis:PutRecords`.

Example IAM policy for Amazon Kinesis:

```javascript
]
}
```

For more information visit [Amazon Kinesis Developer Documentation](https://docs.aws.amazon.com/streams/latest/dev/learning-kinesis-module-one-iam.html).

Configure Kinesis:

```javascript
// Configure the plugin after adding it to the Analytics module

Amplify.configure(
  }
});
```

## Stream data

You can send a data to a Kinesis stream with the standard `record()` method:

```javascript

record(,
  partitionKey: 'myPartitionKey',
  streamName: 'myKinesisStream'
});
```

## Flush events
The recorded events are saved in a buffer and sent to the remote server periodically *(You can tune it with the `flushInterval` option)*. If needed, you have the option to manually clear all the events from the buffer by using the 'flushEvents' API.

```javascript

flushEvents();
```


---

## 📚 Related Topics
- [[Analytics/]]

## 📖 Source
Original: `fragments/lib/analytics/js/streaming.mdx`