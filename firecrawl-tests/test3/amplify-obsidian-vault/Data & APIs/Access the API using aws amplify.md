---
title: Access the API using `aws-amplify`
topics: ['Data & APIs', 'Authentication']
primary_topic: Data & APIs
source: pages/build-a-backend/data/customize-authz/grant-lambda-function-access-to-api/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis, authentication]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]] • [[Authentication/]]
**Primary**: [[Data & APIs/]]

---


# Access the API using `aws-amplify`

Function access to `defineData` can be configured using an authorization rule on the schema object.

```ts title="amplify/data/resource.ts"
import  from '@aws-amplify/backend';

const schema = a
  .schema()
  })
  // highlight-next-line
  .authorization(allow => [allow.resource(functionWithDataAccess)]);

Create a new directory and a resource file, `amplify/functions/data-access/resource.ts`. Then, define the Function with `defineFunction`:

```ts title="amplify/functions/data-access/resource.ts"

The object returned from `defineFunction` can be passed directly to `allow.resource()` in the schema authorization rules. This will grant the function the ability to execute Query, Mutation, and Subscription operations against the GraphQL API. Use the `.to()` method to narrow down access to one or more operations.

```ts title="amplify/data/resource.ts"
const schema = a
  .schema()
  })
  // highlight-start
  .authorization(allow => [
    allow.resource(functionWithDataAccess).to(['query', 'listen'])
  ]); // allow query and subscription operations but not mutations
// highlight-end
```

> **Note**: 

Function access can only be configured on the schema object. It cannot be configured on individual models or fields.

## Access the API using `aws-amplify`

In the handler file for your function, configure the Amplify data client

```ts title="amplify/functions/data-access/handler.ts"

const  = await getAmplifyDataClientConfig(env);

Amplify.configure(resourceConfig, libraryOptions);

const client = generateClient();

> **Note**: 
When configuring Amplify with `getAmplifyDataClientConfig`, your function consumes schema information from an S3 bucket created during backend deployment with grants for the access your function need to use it. Any changes to this bucket outside of backend deployment may break your function.

Once you have generated the client code, update the function to access the data. The following code creates a todo and then lists all todos.

```ts title="amplify/functions/data-access/handler.ts"
//...
const client = generateClient();

  const  = await client.models.Todo.list();

  return event;
};
```


---

## 📚 Related Topics
- [[Data & APIs/]]
- [[Authentication/]]

## 📖 Source
Original: `pages/build-a-backend/data/customize-authz/grant-lambda-function-access-to-api/index.mdx`