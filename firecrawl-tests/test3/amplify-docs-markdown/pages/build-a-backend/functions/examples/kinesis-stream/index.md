---
title: Amazon Kinesis Data Streams
source: pages/build-a-backend/functions/examples/kinesis-stream/index.mdx
---

# Amazon Kinesis Data Streams

With AWS Lambda, you can seamlessly integrate various event sources, such as Amazon Kinesis, Amazon SQS, and others, to trigger Lambda functions in response to real-time events. This feature enables you to build responsive, event-driven applications that react to changes in data or system state without the need for polling services.

In this guide, let us configure a Lambda function with a Kinesis data stream as an event source. The Lambda function is automatically triggered whenever new data is published to the stream - whether you're processing streaming data, reacting to application events, or automating workflows.

To get started, install the AWS Lambda Powertools Logger, which provides structured logging capabilities for your Lambda function, and the `aws-lambda` package, which is used to define the handler type.

```bash title="Terminal" showLineNumbers=
npm add @aws-lambda-powertools/logger @types/aws-lambda
```

Second, create a new directory and a resource file, `amplify/functions/kinesis-function/resource.ts`. Then, define the function with `defineFunction`:

```ts title="amplify/functions/kinesis-function/resource.ts"

Third, create the corresponding handler file, `amplify/functions/kinesis-function/handler.ts`, file with the following contents:

```ts title="amplify/functions/kinesis-function/handler.ts"
import type  from "aws-lambda";

const logger = new Logger();

async function getRecordDataAsync(
  payload: KinesisStreamRecordPayload
): Promise<string> 
```

Lastly, create the Kinesis stream and add it as a event source in the `amplify/backend.ts` file:

```ts title="amplify/backend.ts"

const backend = defineBackend();

const kinesisStack = backend.createStack("kinesis-stack");

const kinesisStream = new Stream(kinesisStack, "KinesisStream", );

const eventSource = new KinesisEventSource(kinesisStream, );

backend.myKinesisFunction.resources.lambda.addEventSource(eventSource);
```

For examples on streaming analytics data to the Kinesis stream from your frontend, see the [Streaming analytics data](/[platform]/build-a-backend/add-aws-services/analytics/streaming-data/) documentation.
</InlineFilter>
