---
title: Step 1 - Set up your custom type
topics: ['Data & APIs']
primary_topic: Data & APIs
source: pages/build-a-backend/data/custom-business-logic/connect-http-datasource/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Step 1 - Set up your custom type

The HTTP Datasource allows you to quickly configure HTTP resolvers within your Data API.

This guide will demonstrate how to establish a connection to an external REST API using an HTTP data source and use Amplify Data's custom mutations and queries to interact with the REST API.

## Step 1 - Set up your custom type

For the purpose of this guide we will define a `Post` type and use an existing external REST API that will store records for it. In Amplify Gen 2, `customType` adds a type to the schema that is not backed by an Amplify-generated DynamoDB table.

With the `Post` type defined, it can then be referenced as the return type when defining your custom queries and mutations.

First, add the `Post` custom type to your schema:

```ts title="amplify/data/resource.ts"

const schema = a.schema()
    .authorization(allow => [allow.publicApiKey()]),
  // highlight-start
  Post: a.customType(),
  // highlight-end
});

## Step 2 - Add your REST API or HTTP API as Datasource

To integrate the external REST API or HTTP API, you'll need to set it up as the HTTP Datasource. Add the following code in your `amplify/backend.ts` file.

```ts title="amplify/backend.ts"

const backend = defineBackend();

const httpDataSource = backend.data.addHttpDataSource(
  "HttpDataSource",
  "https://www.example.com"
);

```
## Step 3 - Define custom queries and mutations

Now that your REST API has been added as a data source, you can reference it in custom queries and mutations using the `a.handler.custom()` modifier which accepts the name of the data source and an entry point for your resolvers.

Use the following code examples to add `addPost`, `getPost`, `updatePost`, and `deletePost` as custom queries and mutations to your schema:

```ts title="amplify/data/resource.ts"

const schema = a.schema(),
  // highlight-start
  addPost: a
    .mutation()
    .arguments()
    .returns(a.ref("Post"))
    .authorization(allow => [allow.publicApiKey()])
    .handler(
      a.handler.custom()
    ),
  // highlight-end
});

const schema = a.schema(),
  // highlight-start
  getPost: a
    .query()
    .arguments()
    .returns(a.ref("Post"))
    .authorization(allow => [allow.publicApiKey()])
    .handler(
      a.handler.custom()
    ),
  // highlight-end
});

const schema = a.schema(),
  // highlight-start
  updatePost: a
    .mutation()
    .arguments()
    .returns(a.ref("Post"))
    .authorization(allow => [allow.publicApiKey()])
    .handler(
      a.handler.custom()
    ),
  // highlight-end
});

const schema = a.schema(),
  // highlight-start
  deletePost: a
    .mutation()
    .arguments()
    .returns(a.ref("Post"))
    .authorization(allow => [allow.publicApiKey()])
    .handler(
      a.handler.custom()
    ),
  // highlight-end
});

## Step 4 - Configure custom business logic handler code

Next, create the following files in your `amplify/data` folder and use the code examples to define custom resolvers for the custom queries and mutations added to your schema from the previous step. These are AppSync JavaScript resolvers.

```js title="amplify/data/addPost.js"

```
</Block>

```js title="amplify/data/deletePost.js"

## Step 5 - Invoke custom queries or mutations

From your generated Data client, you can find all your custom queries and mutations under the client.queries. and client.mutations. APIs respectively.

```ts title="App.tsx"
const  = await client.mutations.addPost();
```
</Block>

```ts title="App.tsx"
const  = await client.queries.getPost();
```
</Block>

```ts title="App.tsx"
const  = await client.mutations.updatePost();
```
</Block>

```ts title="App.tsx"
const  = await client.mutations.deletePost();
```
</Block>
</BlockSwitcher>

## Conclusion

In this guide, you’ve added an external REST API as a HTTP data source to an Amplify Data API and defined custom queries and mutations, handled by AppSync JS resolvers, to manipulate Post items in an external REST API using the Amplify Gen 2 Data client.

To clean up, you can delete your sandbox by accepting the prompt when terminating the sandbox process in your terminal. Alternatively, you can also use the AWS Amplify console to manage and delete sandbox environments.


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `pages/build-a-backend/data/custom-business-logic/connect-http-datasource/index.mdx`