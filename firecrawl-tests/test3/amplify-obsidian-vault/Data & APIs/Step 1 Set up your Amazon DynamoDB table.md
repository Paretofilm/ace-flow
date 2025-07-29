---
title: Step 1 - Set up your Amazon DynamoDB table
topics: ['Data & APIs']
primary_topic: Data & APIs
source: pages/build-a-backend/data/connect-to-existing-data-sources/connect-external-ddb-table/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Step 1 - Set up your Amazon DynamoDB table

The `a.model()` data model allows you to define a GraphQL schema for an AWS AppSync API where models are backed by DynamoDB Tables managed by Amplify. The generated schema also provides queries and mutations to the Amplify Data client. However, you may want to connect to an external DynamoDB table and execute custom business logic against it instead.

> **Note**: 
Using an external DynamoDB table as a data source may be useful if you need to leverage patterns such as single table design.

In the following sections, we walk through the steps to add and use an external DynamoDB table as a data source for your API:

1. Set up your Amazon DynamoDB table
2. Add your Amazon DynamoDB table as a data source
3. Define custom queries and mutations
4. Configure custom business logic handler code
5. Invoke custom queries or mutations

## Step 1 - Set up your Amazon DynamoDB table

For the purpose of this guide we will define a `Post` type and create an external DynamoDB table that will store records for it. In Amplify Gen 2, `customType` adds a type to the schema that is not backed by an Amplify-generated DynamoDB table.

With the `Post` type defined, it can then be referenced as the return type when defining your custom queries and mutations.

First, add the `Post` custom type to your schema:

```ts title="amplify/data/resource.ts"

const schema = a.schema()
    .authorization(allow => [allow.publicApiKey()]),
  // highlight-start
  Post: a.customType(),
  // highlight-end
});

> **Note**: 
**NOTE:** To comply with the GraphQL spec, at least one query is required for a schema to be valid. Otherwise, deployments will fail with a schema error. The Amplify Data schema is auto-generated with a `Todo` model and corresponding queries under the hood. You can leave the `Todo` model in the schema until you add the first custom query to the schema in the next steps.

Once the deployment successfully completes, navigate to the AppSync console and select your Amplify-generated API. Follow these steps to create a new DynamoDB table:

1. On the **Schema** page, choose **Create Resources**.

![AWS AppSync console showing navigation pane with "AWS AppSync" expanded and "APIs" > "TestAPI" selected. Main content displays "Schema Info" section with a "Create Resources" button.](/images/create-ddb-resource-0.png)

2. Choose **Use existing type**, then choose the **Post** type.

![AWS AppSync console, "Create Resources" page. A prominent heading reads "Create Resources". Radio buttons are presented for either defining a new type or selecting an existing type for the table creation.](/images/create-ddb-resource-1.png)

3. Set the **Primary key** to `id` and the **Sort key** to `None`.

4. Disable **Automatically generate GraphQL**. In this example, we'll create the resolver ourselves.

![AWS AppSync console, "Create a table to hold Post objects" page. A table structure is shown with columns and values of "Table name": "PostTable", "Primary Key": "id", and "Sort key": "None". Below the table, there is an option to "Automatically generate GraphQL" which is disabled.](/images/create-ddb-resource-2.png)

5. Choose **Create**.

You now have a new DynamoDB table named `PostTable`, which you can see by visiting `Data sources` in the side tab. You will use this table as the data source for your custom queries and mutations to your Amazon DynamoDB table.

![AWS AppSync console, 'Data sources' page. The page shows a list of existing data sources connected to an API. The data sources include an Amazon DynamoDB table named 'PostTable' and another table named 'Todo'.*](/images/create-ddb-resource-3.png)

## Step 2 - Add your Amazon DynamoDB table as a data source

In your `amplify/backend.ts` file, add your DynamoDB table as a data source for your API:

```ts title="amplify/backend.ts"

// highlight-start
const externalDataSourcesStack = backend.createStack("MyExternalDataSources");

const externalTable = aws_dynamodb.Table.fromTableName(
  externalDataSourcesStack,
  "MyExternalPostTable",
  "PostTable"
);

backend.data.addDynamoDbDataSource(
  "ExternalPostTableDataSource",
  externalTable
);
// highlight-end
```

## Step 3 - Define custom queries and mutations

Now that your DynamoDB table has been added as a data source, you can reference it in custom queries and mutations using the `a.handler.custom()` modifier which accepts the name of the data source and an entry point for your resolvers.

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

Next, create the following files in your `amplify/data` folder and use the code examples to define custom resolvers for the custom queries and mutations added to your schema from the previous step. These are AppSync JavaScript resolvers

```js title="amplify/data/addPost.js"

  return ddb.update(,
    condition:  },
    update: ,
  });
}

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

In this guide, you’ve added an external DynamoDB table as a data source to an Amplify GraphQL API and defined custom queries and mutations, handled by AppSync JS resolvers, to manipulate Post items in an external DynamoDB table using the Amplify Gen 2 Data client.

To clean up, you can delete your sandbox by accepting the prompt when terminating the sandbox process in your terminal. Alternatively, you can also use the AWS Amplify console to manage and delete sandbox environments.

To delete your external DynamoDB table, you can navigate to the AppSync console and click on the name of the table in the data sources list. This takes you to the DynamoDB console where you can delete the table.

## All DynamoDB operations & example resolvers

### GetItem

[Reference](https://docs.aws.amazon.com/appsync/latest/devguide/js-resolver-reference-dynamodb.html#js-aws-appsync-resolver-reference-dynamodb-getitem) - The `GetItem` request lets you tell the AWS AppSync DynamoDB function to make a `GetItem` request to DynamoDB, and enables you to specify:

- The key of the item in DynamoDB
- Whether to use a consistent read or not

**Example:**

```js

### PutItem

[PutItem](https://docs.aws.amazon.com/appsync/latest/devguide/js-resolver-reference-dynamodb.html#js-aws-appsync-resolver-reference-dynamodb-putitem) - The `PutItem` request mapping document lets you tell the AWS AppSync DynamoDB function to make a `PutItem` request to DynamoDB, and enables you to specify the following:

- The key of the item in DynamoDB
- The full contents of the item (composed of key and attributeValues)
- Conditions for the operation to succeed

**Example:**

```js

### UpdateItem

[UpdateItem](https://docs.aws.amazon.com/appsync/latest/devguide/js-resolver-reference-dynamodb.html#js-aws-appsync-resolver-reference-dynamodb-updateitem) - The `UpdateItem` request enables you to tell the AWS AppSync DynamoDB function to make a `UpdateItem` request to DynamoDB and allows you to specify the following:

- The key of the item in DynamoDB
- An update expression describing how to update the item in DynamoDB
- Conditions for the operation to succeed

**Example:**

```js

### DeleteItem

[DeleteItem](https://docs.aws.amazon.com/appsync/latest/devguide/js-resolver-reference-dynamodb.html#js-aws-appsync-resolver-reference-dynamodb-deleteitem) - The `DeleteItem` request lets you tell the AWS AppSync DynamoDB function to make a `DeleteItem` request to DynamoDB, and enables you to specify the following:

- The key of the item in DynamoDB
- Conditions for the operation to succeed

**Example:**

```js

### Query

[Query](https://docs.aws.amazon.com/appsync/latest/devguide/js-resolver-reference-dynamodb.html#js-aws-appsync-resolver-reference-dynamodb-query) - The Query request object lets you tell the AWS AppSync DynamoDB resolver to make a Query request to DynamoDB, and enables you to specify the following:

- Key expression
- Which index to use
- Any additional filter
- How many items to return
- Whether to use consistent reads
- query direction (forward or backward)
- Pagination token

**Example:**

```js

### Scan

[Scan](https://docs.aws.amazon.com/appsync/latest/devguide/js-resolver-reference-dynamodb.html#js-aws-appsync-resolver-reference-dynamodb-scan) - The `Scan` request lets you tell the AWS AppSync DynamoDB function to make a `Scan` request to DynamoDB, and enables you to specify the following:

- A filter to exclude results
- Which index to use
- How many items to return
- Whether to use consistent reads
- Pagination token
- Parallel scans

**Example:**

```js

### Sync

[Sync](https://docs.aws.amazon.com/appsync/latest/devguide/js-resolver-reference-dynamodb.html#js-aws-appsync-resolver-reference-dynamodb-sync) - The `Sync` request object lets you retrieve all the results from a DynamoDB table and then receive only the data altered since your last query (the delta updates). `Sync` requests can only be made to versioned DynamoDB data sources. You can specify the following:

- A filter to exclude results

- How many items to return

- Pagination Token

- When your last Sync operation was started

**Example:**

```js

### BatchGetItem

[BatchGetItem](https://docs.aws.amazon.com/appsync/latest/devguide/js-resolver-reference-dynamodb.html#js-aws-appsync-resolver-reference-dynamodb-batch-get-item) - The `BatchGetItem` request object lets you tell the AWS AppSync DynamoDB function to make a `BatchGetItem` request to DynamoDB to retrieve multiple items, potentially across multiple tables. For this request object, you must specify the following:

- The table names where to retrieve the items from

- The keys of the items to retrieve from each table

The DynamoDB `BatchGetItem` limits apply and **no condition expression** can be provided.

**Example:**
```js

### BatchDeleteItem

[BatchDeleteItem](https://docs.aws.amazon.com/appsync/latest/devguide/js-resolver-reference-dynamodb.html#js-aws-appsync-resolver-reference-dynamodb-batch-delete-item) - The BatchDeleteItem request object lets you tell the AWS AppSync DynamoDB function to make a BatchWriteItem request to DynamoDB to delete multiple items, potentially across multiple tables. For this request object, you must specify the following:

- The table names where to delete the items from

- The keys of the items to delete from each table

The DynamoDB `BatchWriteItem` limits apply and **no condition expression** can be provided.

**Example:**

```js

### BatchPutItem

[BatchPutItem](https://docs.aws.amazon.com/appsync/latest/devguide/js-resolver-reference-dynamodb.html#js-aws-appsync-resolver-reference-dynamodb-batch-put-item) - The `BatchPutItem` request object lets you tell the AWS AppSync DynamoDB function to make a `BatchWriteItem` request to DynamoDB to put multiple items, potentially across multiple tables. For this request object, you must specify the following:

- The table names where to put the items in

- The full items to put in each table

The DynamoDB `BatchWriteItem` limits apply and **no condition expression** can be provided.

**Example:**

```js

### TransactGetItems

[TransactGetItems](https://docs.aws.amazon.com/appsync/latest/devguide/js-resolver-reference-dynamodb.html#js-aws-appsync-resolver-reference-dynamodb-transact-get-items) - The `TransactGetItems` request object lets you to tell the AWS AppSync DynamoDB function to make a `TransactGetItems` request to DynamoDB to retrieve multiple items, potentially across multiple tables. For this request object, you must specify the following:

- The table name of each request item where to retrieve the item from

- The key of each request item to retrieve from each table

The DynamoDB `TransactGetItems` limits apply and **no condition expression** can be provided.

**Example:**

```js

### TransactWriteItems

[TransactWriteItems](https://docs.aws.amazon.com/appsync/latest/devguide/js-resolver-reference-dynamodb.html#js-aws-appsync-resolver-reference-dynamodb-transact-write-items) - The `TransactWriteItems` request object lets you tell the AWS AppSync DynamoDB function to make a `TransactWriteItems` request to DynamoDB to write multiple items, potentially to multiple tables. For this request object, you must specify the following:

- The destination table name of each request item

- The operation of each request item to perform. There are four types of operations that are supported: `PutItem`, `UpdateItem`, `DeleteItem`, and `ConditionCheck`

- The key of each request item to write

The DynamoDB `TransactWriteItems` limits apply.

**Example:**

```js


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `pages/build-a-backend/data/connect-to-existing-data-sources/connect-external-ddb-table/index.mdx`