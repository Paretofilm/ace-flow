---
title: DynamoDB Streams
topics: ['Functions']
primary_topic: Functions
source: pages/build-a-backend/functions/examples/dynamo-db-stream/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, functions]
---


## 🧭 Navigation
**Topics**: [[Functions/]]
**Primary**: [[Functions/]]

---


# DynamoDB Streams

With AWS Lambda, you can seamlessly integrate various event sources, such as Amazon DynamoDB, Amazon SQS, and others, to trigger Lambda functions in response to real-time events. This feature enables you to build responsive, event-driven applications that react to changes in data or system state without the need for polling services.

In this guide, lets configure a Lambda function with an Amazon DynamoDB stream as an event source. The Lambda function is automatically triggered whenever an item is added, updated, or deleted from the table, enabling you to build real-time applications that react to changes in your data. In this example, we will use a `Todo` table created by a data model on the GraphQL API.

To get started, install the AWS Lambda Powertools Logger, which provides structured logging capabilities for your Lambda function, and the `aws-lambda` package, which is used to define the handler type.

```bash title="Terminal" showLineNumbers=
npm add --save-dev @aws-lambda-powertools/logger @types/aws-lambda
```

Second, create a new directory and a resource file, `amplify/functions/dynamoDB-function/resource.ts`. Then, define the function with `defineFunction`:

```ts title="amplify/functions/dynamoDB-function/resource.ts"

Third, create the corresponding handler file, `amplify/functions/dynamoDB-function/handler.ts`, file with the following contents:

```ts title="amplify/functions/dynamoDB-function/handler.ts"

const logger = new Logger();

    if (record.eventName === "INSERT") `);
    }
  }
  logger.info(`Successfully processed $ records.`);

  return ;
};
```

Lastly, create DynamoDB table as event source in the `amplify/backend.ts` file:

```ts title="amplify/backend.ts"

const backend = defineBackend();

const todoTable = backend.data.resources.tables["Todo"];
const policy = new Policy(
  Stack.of(todoTable),
  "MyDynamoDBFunctionStreamingPolicy",
  ),
    ],
  }
);
backend.myDynamoDBFunction.resources.lambda.role?.attachInlinePolicy(policy);

const mapping = new EventSourceMapping(
  Stack.of(todoTable),
  "MyDynamoDBFunctionTodoEventStreamMapping",
  
);

mapping.node.addDependency(policy);
```


---

## 📚 Related Topics
- [[Functions/]]

## 📖 Source
Original: `pages/build-a-backend/functions/examples/dynamo-db-stream/index.mdx`