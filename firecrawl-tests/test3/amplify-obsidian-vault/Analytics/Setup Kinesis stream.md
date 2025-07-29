---
title: Setup Kinesis stream
topics: ['Analytics', 'Data & APIs']
primary_topic: Analytics
source: pages/build-a-backend/add-aws-services/analytics/streaming-data/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, analytics, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Analytics/]] • [[Data & APIs/]]
**Primary**: [[Analytics/]]

---


# Setup Kinesis stream

The Amazon Kinesis analytics provider allows you to send analytics data to an [Kinesis](https://aws.amazon.com/kinesis) stream for real-time processing.

## Setup Kinesis stream

The following is an example utilizing the [AWS Cloud Development Kit (AWS CDK)](https://docs.aws.amazon.com/cdk/latest/guide/home.html) to create the Analytics resource powered by [Amazon Kinesis](https://aws.amazon.com/kinesis).

```ts title="amplify/backend.ts"

const backend = defineBackend();

// create a new stack for the Kinesis stream
const kinesisStack = backend.createStack("kinesis-stack");

// create a new Kinesis stream with one shard
const kinesisStream = new Stream(kinesisStack, "KinesisStream", );

// create a new policy to allow PutRecords to the Kinesis stream
const kinesisPolicy = new Policy(kinesisStack, "KinesisPolicy", ),
  ],
});

// apply the policy to the authenticated and unauthenticated roles
backend.auth.resources.authenticatedUserIamRole.attachInlinePolicy(kinesisPolicy);
backend.auth.resources.unauthenticatedUserIamRole.attachInlinePolicy(kinesisPolicy);
```

## Installation and Configuration

If you did not use the CLI, ensure you have [setup IAM permissions](https://docs.aws.amazon.com/streams/latest/dev/learning-kinesis-module-one-iam.html) for `kinesis:PutRecords`.

Example IAM policy for Amazon Kinesis:

```javascript
]
}
```

For more information visit the [Amazon Kinesis Developer Documentation](https://docs.aws.amazon.com/streams/latest/dev/learning-kinesis-module-one-iam.html).

Configure Kinesis:

```javascript title="src/index.js"
// Configure the plugin after adding it to the Analytics module

const amplifyConfig = parseAmplifyConfig(outputs);

Amplify.configure(
  }
});
```

## Stream data

You can send a data to a Kinesis stream with the standard `record()` method:

```javascript title="src/index.js"

record(,
  partitionKey: 'myPartitionKey',
  streamName: 'myKinesisStream'
});
```

## Flush events
The recorded events are saved in a buffer and sent to the remote server periodically *(You can tune it with the `flushInterval` option)*. If needed, you have the option to manually clear all the events from the buffer by using the 'flushEvents' API.

```javascript title="src/index.js"

flushEvents();
```

## Known Issues

When importing alternative service providers listed below, instead of the default Pinpoint provider:

- Kinesis (`aws-amplify/analytics/kinesis`)
- Kinesis Data Firehose (`aws-amplify/analytics/kinesis-firehose`)
- Personalize Event (`aws-amplify/analytics/personalize`)

you may encounter the following error when starting the bundler:

> Error: Unable to resolve module stream from /path/to/node_modules/@aws-sdk/... This is a [known issue](https://github.com/aws/aws-sdk-js-v3/issues/4877). Please follow [the steps](https://github.com/aws/aws-sdk-js-v3/issues/4877#issuecomment-1656007484) outlined in the issue to resolve the error.

</InlineFilter>


---

## 📚 Related Topics
- [[Analytics/]]
- [[Data & APIs/]]

## 📖 Source
Original: `pages/build-a-backend/add-aws-services/analytics/streaming-data/index.mdx`