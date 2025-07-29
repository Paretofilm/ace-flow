---
title: Step 1 - Define a custom mutation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: pages/build-a-backend/data/custom-business-logic/batch-ddb-operations/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Step 1 - Define a custom mutation

Batch DynamoDB operations allow you to add multiple items in single mutation.

## Step 1 - Define a custom mutation

```ts title="amplify/data/resource.ts"

const schema = a.schema(),

  // 2. Define your mutation with the return type and, optionally, arguments
  BatchCreatePost: a
    .mutation()
    // arguments that this query accepts
    .arguments()
    .returns(a.ref('Post').array())
    // only allow signed-in users to call this API
    .authorization(allow => [allow.authenticated()])
});

## Step 2 - Configure custom business logic handler code

After your query or mutation is defined, you need to author your custom business logic using a [custom resolver powered by AppSync JavaScript resolver](https://docs.aws.amazon.com/appsync/latest/devguide/tutorials-js.html).

Custom resolvers work on a "request/response" basis. You choose a data source, map your request to the data source's input parameters, and then map the data source's response back to the query/mutation's return type. Custom resolvers provide the benefit of no cold starts, less infrastructure to manage, and no additional charge for Lambda function invocations. Review [Choosing between custom resolver and function](https://docs.aws.amazon.com/appsync/latest/devguide/resolver-reference-overview-js.html#choosing-data-source).

In your `amplify/data/resource.ts` file, define a custom handler using `a.handler.custom`.

```ts title="amplify/data/resource.ts"

const schema = a.schema(),

  BatchCreatePost: a
    .mutation()
    .arguments()
    .returns(a.ref('Post').array())
    .authorization(allow => [allow.authenticated()])
    // 1. Add the custom handler
    .handler(
      a.handler.custom()
    )
});

Amplify will store some values in the resolver context stash that can be accessed in the custom resolver.

| Name                      | Description                                  |
| ------------------------- | -------------------------------------------- |
| awsAppsyncApiId           | The ID of the AppSync API.                   |
| amplifyApiEnvironmentName | The Amplify api environment name. (`NONE` in sandbox) |

The Amplify generated DynamoDB table names can be constructed from the variables in the context stash. The table name is in the format `<model-name>-<aws-appsync-api-id>-<amplify-api-environment-name>`. For example, the table name for the `Post` model would be `Post-123456-dev` where `123456` is the AppSync API ID and `dev` is the Amplify API environment name.

```ts title="amplify/data/BatchCreatePostHandler.js"

  return -$`]: ctx.args.contents.map((content) =>
        util.dynamodb.toMapValues()
      ),
    },
  };
}

## Step 3 - Invoke the custom query or mutation

From your generated Data client, you can find all your custom queries and mutations under the `client.queries.` and `client.mutations.` APIs respectively.

```ts
const  = await client.mutations.BatchCreatePost();
```


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `pages/build-a-backend/data/custom-business-logic/batch-ddb-operations/index.mdx`