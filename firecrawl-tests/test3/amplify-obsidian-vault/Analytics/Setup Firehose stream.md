---
title: Setup Firehose stream
topics: ['Analytics', 'Data & APIs']
primary_topic: Analytics
source: pages/build-a-backend/add-aws-services/analytics/storing-data/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, analytics, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Analytics/]] • [[Data & APIs/]]
**Primary**: [[Analytics/]]

---


# Setup Firehose stream

The Amazon Data Firehose analytics provider allows you to send analytics data to an [Amazon Data Firehose](https://aws.amazon.com/firehose/) stream for reliably storing data.

## Setup Firehose stream

The following is an example utilizing the [AWS Cloud Development Kit (AWS CDK)](https://docs.aws.amazon.com/cdk/latest/guide/home.html) to create the Analytics resource powered by [Amazon Data Firehose](https://aws.amazon.com/firehose/).

Let's create a storage bucket to store the data from the Firehose stream.

```ts title="amplify/storage/resource.ts"

// Define the S3 bucket resource

```

next, let's create the Firehose resource.

```ts title="amplify/backend.ts"
import  from "aws-cdk-lib/aws-iam";

const backend = defineBackend();

// Create a new stack for the Firehose resources
const firehoseStack = backend.createStack("firehose-stack");

// Access the S3 bucket resource
const s3Bucket = backend.storage.resources.bucket;

// Create a new IAM role for the Firehose
const firehoseRole = new Role(firehoseStack, "FirehoseRole", );

// Grant the Firehose role read/write permissions to the S3 bucket
s3Bucket.grantReadWrite(firehoseRole);

// Create a new Firehose delivery stream
const myFirehose = new CfnDeliveryStream(firehoseStack, "MyFirehose", ,
  deliveryStreamName: "myFirehose",
});

// Create a new IAM policy to allow users to write to the Firehose
const firehosePolicy = new Policy(firehoseStack, "FirehosePolicy", ),
  ],
});

// Attach the policy to the authenticated and unauthenticated IAM roles
backend.auth.resources.authenticatedUserIamRole.attachInlinePolicy(firehosePolicy);
backend.auth.resources.unauthenticatedUserIamRole.attachInlinePolicy(firehosePolicy);
```

## Installation and Configuration

Ensure you have [setup IAM permissions](https://docs.aws.amazon.com/firehose/latest/dev/controlling-access.html) for `firehose:PutRecordBatch`.

Example IAM policy for Amazon Data Firehose:

```javascript
]
}
```

Configure Firehose:

```javascript title="src/index.js"

const amplifyConfig = parseAmplifyConfig(outputs);

Amplify.configure(
  }
});
```

## Storing data

You can send a data to a Firehose stream with the standard `record` method. Any data is acceptable and `streamName` is required:

```javascript title="src/index.js"

record(,
  streamName: 'myFirehose'
});
```

## Flush events
The recorded events are saved in a buffer and sent to the remote server periodically *(You can tune it with the `flushInterval` option)*. If needed, you have the option to manually clear all the events from the buffer by using the 'flushEvents' API.

```javascript title="src/index.js"

flushEvents();
```

## Known Issues

When importing alternative service providers listed below, instead of the default Pinpoint provider:

- Amazon Kinesis (`aws-amplify/analytics/kinesis`)
- Amazon Data Firehose (`aws-amplify/analytics/kinesis-firehose`)
- Personalize Event (`aws-amplify/analytics/personalize`)

you may encounter the following error when starting the bundler:

> Error: Unable to resolve module stream from /path/to/node_modules/@aws-sdk/... This is a [known issue](https://github.com/aws/aws-sdk-js-v3/issues/4877). Please follow [the steps](https://github.com/aws/aws-sdk-js-v3/issues/4877#issuecomment-1656007484) outlined in the issue to resolve the error.

</InlineFilter>


---

## 📚 Related Topics
- [[Analytics/]]
- [[Data & APIs/]]

## 📖 Source
Original: `pages/build-a-backend/add-aws-services/analytics/storing-data/index.mdx`